Check kubernetes version
```execute
kubectl version
```

Check for files
```execute
ls database/
```

See what resources Kubernetes will create when directory called `database/` is processed
```execute
kubectl apply -f database/ --dry-run=client
```

Deploy the database component
```execute
kubectl apply -f database/
```

See Deployments
```execute
kubectl get deployments
```

Monitor Deployment Progress
```execute
kubectl rollout status deployment/blog-db
```

Exec into pod & Check Version
```
kubectl get pods
kubectl exec --stdin --tty blog-db-7b948568cf-qp96s -- /bin/bash
psql --version
```
or 
```kubectl exec -it blog-db-7b948568cf-qp96s -- psql --version
```

Create postgres alias
```
alias psql='kubectl exec -it blog-db-7b948568cf-qp96s -- psql'
psql --version
```


Othe Postgres cmmands
https://www.geeksforgeeks.org/postgresql-psql-commands/