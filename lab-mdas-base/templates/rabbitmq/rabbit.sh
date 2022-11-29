SERVER_NAME=rabbitmq-cluster

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
kubectl config set-context --current --namespace=rabbitmq-system
k apply -f templates/rabbitmq/$SERVER_NAME.yaml
kubectl wait pods -n rabbitmq-system $SERVER_NAME-server-0 --for condition=Ready --timeout=90s

# RESOURCE LIMITS MUST BE MET
# Cluster minimum cpu = 10
# Cluster requests memory = 2Gi
# Cluster requests cpu = 2

# session.namespaces.budget = xx-large (test)
# session.namespaces.limits.min.cpu = 10m (test)
# session.namespaces.limits.max.memory = 16Gi
# session.applications.vcluster.resources.syncer.memory = 4Gi (test)