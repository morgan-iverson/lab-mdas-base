#!/bin/bash
export POSTGRES_CONFIG_HOME=~/templates/postgres/config
kubectl apply -f $POSTGRES_CONFIG_HOME
kubectl rollout status deployment/postgres
# echo "export POSTGRES_POD_NAME=$(kubectl get pod -l app=postgres -o jsonpath="{.items[0].metadata.name}")
# alias psql='kubectl exec -it $POSTGRES_POD_NAME -- psql'
# " >> /root/.bashrc
# psql --version

#This script is is failing at export POSTGRES_POD_NAME
# Runs fine if copy paste
