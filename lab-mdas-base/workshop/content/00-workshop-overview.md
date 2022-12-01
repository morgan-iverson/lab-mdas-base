This is the initial landing page for your workshop. Include in this page a description of what your workshop is about.

## TEST ENV VARIABLES

{{ ENV_TEST }}

## Environment Set Up 
This will be moved to set up envornment once environment set up is complete


## RabbitMQ
RabbitMQ is a....

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
**Note:** RabbitMQ is currently running in a docker container.

```execute
docker ps --format "$DOCKER_FORMAT"
```

 
## Postgres 
Postgress is a...

We are running Postgres 12.7.
```execute
psql --version
```

**Note:** Postgres is running in Kubernetes
```execute
type psql
```


## Gemfire
Gemfire is a ...

We are running Gemfire v##.

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