# Start GemFire


<!-- ```shell

```
cd ~/spring-modern-data-architecture/data-services/gemfire/vmware-gemfire-9.15.0/bin
cp -r ~/spring-modern-data-architecture/data-services/gemfire/gemfire-for-redis-apps-1.0.1 /tmp
./gfsh
```

In Gfsh -->

```execute
gfsh
```

```terminal:execute
command: start locator --name=locator --locators=127.0.0.1[10334] --bind-address=127.0.0.1 --hostname-for-clients=127.0.0.1  --jmx-manager-hostname-for-clients=127.0.0.1 --http-service-bind-address=127.0.0.1
session: gemfire
```

```terminal:execute
command: start server --name=redisServer1   --locators=127.0.0.1[10334]  --server-port=40404 --bind-address=127.0.0.1 --hostname-for-clients=127.0.0.1 --start-rest-api=true --http-service-bind-address=127.0.0.1 --http-service-port=9090  --J=-Dgemfire-for-redis-port=6379 --J=-Dgemfire-for-redis-enabled=true --classpath=/tmp/gemfire-for-redis-apps-1.0.1/lib/*  
session: gemfire
```

Verify Servers Running in Gfsh

- The following should contain member names (locator and redisServer1)

```terminal:execute
list members
```