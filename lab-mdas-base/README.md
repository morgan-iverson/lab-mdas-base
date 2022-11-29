Starter Workshop
================

Starter workshop for Educates


## Create RabbitMQ Operator in Educats vcluster
1. Create Operator Resources
    ```
    kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"


    // k get all -n rabbitmq-system
    // kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/docs/examples/hello-world/rabbitmq.yaml -n rabbitmq-system
    ```

2. Confirm Service Availability
    ```
    kubectl get customresourcedefinitions.apiextensions.k8s.io
    ```

3. Set Namespace Preference
    ```
    kubectl config set-context --current --namespace=rabbitmq-system


    // Validate it
    kubectl config view --minify | grep namespace:
    ```
4. Create a cluster resource
    ```
    cat <<EOF | kubectl apply -f -
    apiVersion: rabbitmq.com/v1beta1
    kind: RabbitmqCluster
    metadata:
        name: definition
        namespace: rabbitmq-system
    EOF


    k apply -f templates/rabbitmq/$SERVER_NAME.yaml
    k apply -f templates/rabbitmq/rabbitmq-cluster.yaml 
    ```

5. Wait until Ready (or use next step)
    ```
    kubectl wait pods -n rabbitmq-system definition-server-0 --for condition=Ready --timeout=90s

    // kubectl wait statefulset.apps -n rabbitmq-system definition-server --for condition=Ready --timeout=90s
    ```
5. Check on resource
    ```
    kubectl get all -l app.kubernetes.io/name=definition -n rabbitmq-system
    ```

6. 

## pod/definition-server-0 Pending...
```
$ k describe pod/definition-server-0

Warning  SyncError  61s (x17 over 6m32s)  pod-syncer  Error syncing to physical 
cluster: pods "definition-server-0-x-rabbitmq-system-x-my-vcluster" is forbidden: 
exceeded quota: compute-resources, 
requested: limits.cpu=2,limits.memory=2Gi, 
used: limits.cpu=1200m,limits.memory=670Mi, 
limited: limits.cpu=2,limits.memory=2Gi```
```
Note: (docs.educates)
Other control plane services for the virtual cluster are deployed in a separate 
namespace of the underlying host Kubernetes cluster so don’t count in the resource 
budget. Those control plane services do reserve significant resources which may in 
many cases be more than what is required. The defaults are 1Gi for the virtual 
cluster syncer application and 2Gi for the k3s instance used by the virtual cluster. 
To override these values to reduce memory reserved, or increase it, add a 
session.applications.vcluster.resources section.

### Budgets (docs.educates)

| Budget    | CPU   | Memory |
|-----------|-------|--------|
| small     | 1000m | 1Gi    |
| medium    | 2000m | 2Gi    |
| large     | 4000m | 4Gi    |
| x-large   | 8000m | 8Gi    |
| xx-large  | 8000m | 12Gi   |
| xxx-large | 8000m | 16Gi   |


### Resolution:
**Problem:** Resource Budget is too small & Syncer Memory Limits too low (The error is coming from vcluster pod-syncer)
**Resolution:** Increase resource budget (sessions.namespaces.budget=medium -> custom, add session.namespaces.limits) & Increase Syncer Memory Limits (session.vcluser.resource.syncer.memory = 1Gi (default) -> 4Gi)
**Result:** Success!

## pod/definition-server-0 Pending...
```
$ k describe pod/definition-server-0
Warning  SyncError  7s (x13 over 28s)  pod-syncer  Error syncing to physical cluster: pods "definition-server-0-x-rabbitmq-system-x-my-vcluster" is forbidden: minimum cpu usage per Container is 50m, but request is 10m
```

**Problem:** Current vcluster cpu min = spec.namespaces.limits.min.cpu = 50m. 
**Resolution:** spec.namespaces.limits.min.cpu = 5m
**Result:** Success!

[RabbitMQCluster Resource Requirements](https://www.rabbitmq.com/kubernetes/operator/using-operator.html#resource-reqs)

Memory limit: 2 Gi
CPU limit: 2000 millicores
Memory request: 2 Gi
CPU request: 1000 millicores

# About Virtual Kubernetes CLuster/vcluster
vcluster
Runs as a single pod made of 2 containers:
(scheduled by a stateful set)

Control Plane:
This container contains API server, 
controller manager and a connection (or mount) of the 
data store. By default, vclusters use sqlite as data store
and run the API server and *** controller manager of k3s, which
is a certified Kubernetes distribution and CNCF sandbox 
project.*** 

Syncer: 
What makes a vcluster virtual is the fact that it 
does not have actual worker nodes or network. Instead, it 
uses a so-called syncer which *** copies the pods that are 
created within the vcluster to the underlying host cluster.***
Then, the host cluster will actually schedule the pod and 
the vcluster will keep the vcluster pod and host cluster 
pod in sync.
