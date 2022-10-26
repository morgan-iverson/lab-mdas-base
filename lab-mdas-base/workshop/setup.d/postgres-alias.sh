kubectl apply -f ~/templates/postgres
kubectl rollout status deployment/postgres
export POSTGRES_POD_NAME=$(kubectl get pod -l app=postgres -o jsonpath="{.items[0].metadata.name}")
alias psql='kubectl exec -it $POSTGRES_POD_NAME -- psql'
psql --version

#This script is not building kube objects on start up