This is the initial landing page for your workshop. Include in this page a description of what your workshop is about.

## Environment Set Up 
This will be moved to set up envornment once environment set up is complete

## Postgres 
**Note:** Resolving processing failures until then run the following scripts on start up to set up psql command:
```execute 
POSTGRES_POD_NAME=$(kubectl get pod -l app=postgres -o jsonpath="{.items[0].metadata.name}")
alias psql='kubectl exec -it $POSTGRES_POD_NAME -- psql'
```

Postgres is running in Kubernetes
```execute
type psql
```
Check Postgres version
```execute
psql --version
```
## RabbitMQ
In progress...

## Gemfire

Check that Gemfire is installed
```execute
gfsh version
```

## Java 
```execute
java --version
```