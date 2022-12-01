#!bin/bash

SERVER_NAME=rabbitmq-cluster

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kubectl config set-context --current --namespace=rabbitmq-system

echo "Waiting for pod creation to complete..."
k apply -f templates/rabbitmq/$SERVER_NAME.yaml

STATUS=1; 
ATTEMPTS=0; 
POD_STATUS_CMD="kubectl get pod/$SERVER_NAME-server-0 -n rabbitmq-system"; 

until [ $STATUS -eq 0 ] || $POD_STATUS_CMD || [ $ATTEMPTS -eq 5 ]; 
do echo "Checking for pod..."; sleep 5; $POD_STATUS_CMD; STATUS=$?; ATTEMPTS=$((ATTEMPTS + 1)); 
done

echo "STATUS=$STATUS"
echo "ATTEMPTS=$ATTEMPTS"

if [[ ATTEMPTS -gt 5  && $STATUS -eq 1]];
then echo "Timeout Exceeded. Pod not created!"
else
    echo "Pod Created!"
    echo "Waiting for Pod to be Ready..."
    kubectl wait pods -n rabbitmq-system $SERVER_NAME-server-0 --for condition=Ready --timeout=90s

    kubectl get all -l app.kubernetes.io/name=$SERVER_NAME
    kubectl port-forward "service/$SERVER_NAME" 15672
fi

