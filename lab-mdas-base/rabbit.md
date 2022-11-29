## 
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
# k get all -n rabbitmq-system
# kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/docs/examples/hello-world/rabbitmq.yaml -n rabbitmq-system

Set Namespace Preference
kubectl config set-context --current --namespace=rabbitmq-system

# Validate it
kubectl config view --minify | grep namespace:


Confirm Service Availability
kubectl get customresourcedefinitions.apiextensions.k8s.io

Create a cluster resource

cat <<EOF | kubectl apply -f -
apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
  name: definition
  namespace: rabbitmq-system
EOF


pod/definition-server-0 Pending...
Warning  SyncError  61s (x17 over 6m32s)  pod-syncer  Error syncing to physical 
cluster: pods "definition-server-0-x-rabbitmq-system-x-my-vcluster" is forbidden: 
exceeded quota: compute-resources, 
requested: limits.cpu=2,limits.memory=2Gi, 
used: limits.cpu=1200m,limits.memory=670Mi, 
limited: limits.cpu=2,limits.memory=2Gi


Note: (docs.educates)
Other control plane services for the virtual cluster are deployed in a separate 
namespace of the underlying host Kubernetes cluster so don’t count in the resource 
budget. Those control plane services do reserve significant resources which may in 
many cases be more than what is required. The defaults are 1Gi for the virtual 
cluster syncer application and 2Gi for the k3s instance used by the virtual cluster. 
To override these values to reduce memory reserved, or increase it, add a 
session.applications.vcluster.resources section.

Budgets (docs.educates)

| Budget    | CPU   | Memory |
|-----------|-------|--------|
| small     | 1000m | 1Gi    |
| medium    | 2000m | 2Gi    |
| large     | 4000m | 4Gi    |
| x-large   | 8000m | 8Gi    |
| xx-large  | 8000m | 12Gi   |
| xxx-large | 8000m | 16Gi   |


Resolution:
The error is coming from vcluster pod-syncer.
1) Increase total resoucre budget medium -> xxx-large & Test
2) Set the syncer memory limits to permit pod request. 
Syncer default is 1Gi = 1019Mi.
k3s default is 2Gi = 2038Mi.
RabbitmqCluster needs 2Gi -> Syncer.memory = 4Gi

Rabbitmq pod 

Create Cluster in wokshop.yaml (https://docs.educates.dev/custom-resources/workshop-definition.html?highlight=budget#creating-additional-namespaces)

Verify success 
kubectl get all -l app.kubernetes.io/name=definition -n rabbitmq-system

Set Namespace Preference
kubectl config set-context --current --namespace=rabbitmq-system
# Validate it
kubectl config view --minify | grep namespace:



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
