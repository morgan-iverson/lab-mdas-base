function initialize(workshop) {
    workshop.load_workshop();

    workshop.data_variable('TEST', '"put rabbit secrets here"');
    workshop.data_variable("TEST2", "echo $RMQ_PASSWORD")
}

exports.default = initialize;

module.exports = exports.default;