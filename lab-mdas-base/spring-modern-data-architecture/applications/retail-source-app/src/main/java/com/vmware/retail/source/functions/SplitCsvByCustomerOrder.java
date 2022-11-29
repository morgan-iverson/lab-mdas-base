package com.vmware.retail.source.functions;

import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import nyla.solutions.core.io.csv.CsvReader;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.io.StringReader;
import java.util.function.Consumer;

@Component
@Slf4j
public class SplitCsvByCustomerOrder implements Consumer<String> {

    private final int customerIdCol;
    private final int orderIdCol;
    private final String exchange;
    private final CsvToCustomerOrder streamBridge;

    private final RabbitTemplate rabbitTemplate;

    public SplitCsvByCustomerOrder(CsvToCustomerOrder csvToCustomerOrder,
                                   @Value("${spring.cloud.stream.bindings.csvToCustomerOrder-out-0.destination}")
                                   String exchange,
                                   @Value("${source.splitCsv.consumer.customerIdCol}")
                                   int customerIdCol,
                                   @Value("${source.splitCsv.consumer.orderIdCol}")
                                   int orderIdCol, RabbitTemplate rabbitTemplate) {
        this.exchange = exchange;
        this.streamBridge = csvToCustomerOrder;
        this.customerIdCol = customerIdCol;
        this.orderIdCol = orderIdCol;
        this.rabbitTemplate = rabbitTemplate;
    }

    @SneakyThrows
    @Override
    public void accept(String csv) {
        log.info("Csv\n{}", csv);

        if (csv == null || csv.trim().length() == 0) {
            log.warn("Ignore empty CSV\n{}", csv);
            return;
        }

        var csvReader = new CsvReader(new StringReader(csv));
        var csvList = csvReader
                .selectBuilder()
                .orderBy(customerIdCol)
                .groupBy(orderIdCol)
                .buildCsvText();

        String customerId = csvReader.get(0, customerIdCol, CsvReader.DataType.String);

        // return csvList.stream().map(csvCustomerOrder -> streamBridge.apply(csvCustomerOrder)).toList();
        csvList.forEach(outCsv -> {
            rabbitTemplate.convertAndSend(exchange, customerId, this.streamBridge.apply(outCsv));
        });

        //        csvList.forEach(outCsv -> this.streamBridge.send(exchange,customerId, MessageBuilder
        //                .withBody(outCsv.getBytes(StandardCharsets.UTF_8))
        //                .setContentType(MediaType.TEXT_PLAIN_VALUE).build()));
    }
}

