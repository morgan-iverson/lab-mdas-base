# Start RabbitMQ 

[ Description of Activity ]

## RabbitMQ Cluster Operator
[ Description of Item & Task ]

```terminal:execute
k get all -l app.kubernetes.io/name=rabbitmq-cluster -n {{ RMQ_KUB_NAMESPACE }}
session: rabbitmq
```

## RabbitMQ Cluster 
[ Description of Item & Task ]

```terminal:execute
kubectl get all -l app.kubernetes.io/name=$RABBITMQ_SERVER_NAME
session: rabbitmq
```
 
### Start RabbitMQ Management UI Server
[ Description of Task ]
```terminal:execute
command: kubectl port-forward "service/$RABBITMQ_SERVER_NAME" 15672
session: rabbitmq
```

### Your RMQ Management UI Login Information is:
[ Description of Task ]

**Username:**
```copy
{{ ENV_RMQ_USERNAME }}
```

**Password:** 
```copy 
{{ ENV_RMQ_PASSWORD }}
```


### Open RMQ Management UI
[ Description of Task ]

```dashboard:open-dashboard
name: RabbitMQ
```