#!/bin/bash

RABBITMQ_SERVER_NAME=rabbitmq-cluster

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kubectl config set-context --current --namespace=rabbitmq-system

echo "Waiting for pod creation to complete..."
kubectl apply -f ~/templates/rabbitmq/$RABBITMQ_SERVER_NAME.yaml

STATUS=1; 
TIMEOUT=90;
DELAY=5;
ATTEMPTS=$((TIMEOUT/DELAY)); 
POD_STATUS_CMD="kubectl get pod/$RABBITMQ_SERVER_NAME-server-0 -n rabbitmq-system"; 

until [ $STATUS -eq 0 ] || $POD_STATUS_CMD || [ $ATTEMPTS -eq 0 ]; 
do echo "Checking for pod..."; sleep $DELAY; $POD_STATUS_CMD; STATUS=$?; ATTEMPTS=$((ATTEMPTS - 1)); 
done

if [[ $ATTEMPTS -le 0  && $STATUS -eq 1 ]]
then echo "Timeout Exceeded. Pod not created!"
else
    echo "Pod Created in $((TIMEOUT - (ATTEMPTS * DELAY))) seconds!"
    echo "Waiting for Pod to be Ready..."
    kubectl wait pods -n rabbitmq-system $RABBITMQ_SERVER_NAME-server-0 --for condition=Ready --timeout=90s

    kubectl get all -l app.kubernetes.io/name=$RABBITMQ_SERVER_NAME
    # will cause start up to hang: kubectl port-forward "service/$RABBITMQ_SERVER_NAME" 15672
fi


# WATCH LOGS
# $ns = session-namespace = $kubectl get ns (your computer) the sesion ns will look like 'lab-mdas-base-w01'
# $pod = pod in session ns k get pods -n $ns
# -f = follow (live)
# k logs pod/$pod -n $ns -f 

# PREREQUISITES
# [RabbitMQCluster Resource Requirements](https://www.rabbitmq.com/kubernetes/operator/using-operator.html#resource-reqs)

# Memory limit: 2 Gi
# CPU limit: 2000 millicores
# Memory request: 2 Gi
# CPU request: 1000 millicores