This is the initial landing page for your workshop. Include in this page a description of what your workshop is about.

## Environment Set Up 
This will be moved to set up envornment once environment set up is complete


## RabbitMQ
RabbitMQ is a....

### Start RabbitMQ Management Server
```terminal:execute
command: kubectl port-forward "service/$RABBITMQ_SERVER_NAME" 15672
session: rabbitmq
```

### Your RMQ Management UI Login Information is:

**Username:**
```copy
{{ ENV_RMQ_USERNAME }}
```

**Password:** 
```copy 
{{ ENV_RMQ_PASSWORD }}
```


### Open RMQ Management UI
```dashboard:open-dashboard
name: RabbitMQ
```

## Open Rabbit MWQ in a new tab
```copy
http://rabbitmq-{{session_namespace}}.{{ingress_domain}}
```

## Open Editor in a new tab 
```copy
http://editor-{{session_namespace}}.{{ingress_domain}}
```


```terminal:execute
command: gfsh version
session: gemfire
```



## Java 
Java is a ...

This workshop is running on an image based on Java 17.
```execute
java --version
```

### Extras
```editor:open-file
file: ~/spring-modern-data-architecture/description.txt
```
<!-- ```editor:select-matching-text
file: ~/exercises/sample.txt
text: "int main()"
``` -->