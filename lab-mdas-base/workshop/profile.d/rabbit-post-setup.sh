export SERVER_NAME=rabbitmq-cluster

export RMQ_USERNAME="$(kubectl get secret $SERVER_NAME-default-user -o jsonpath='{.data.username}' | base64 --decode)"
echo "username: $RMQ_USERNAME"

export RMQ_PASSWORD="$(kubectl get secret $SERVER_NAME-default-user -o jsonpath='{.data.password}' | base64 --decode)"
echo "password: $RMQ_PASSWORD"
