#!/bin/bash

export POSTGRES_CONFIG_HOME=~/templates/postgres/config
kubectl apply -f $POSTGRES_CONFIG_HOME
kubectl rollout status deployment/postgres
export POSTGRES_POD_NAME=$(kubectl get pod -l app=postgres -o jsonpath="{.items[0].metadata.name}")
# alias psql='kubectl exec -it $POSTGRES_POD_NAME -- psql'
# psql --version

# The environment variables need to be set permanently in the shell via .bashrc .bash_profile .profile