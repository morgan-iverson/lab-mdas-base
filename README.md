lab-mdas-base
===========================

This is to be used as the base image for lab-spring-one-mdas

This needs to have packages for the following tools:
* java 17
* redis
* gemfire
* rabbitmq
* postgres

Example

lab/lab/resources/workshop.yaml
```
packages:
    - name: docker
      files:
      - image: 
        url: ghcr.io/vmware-tanzu-labs/educates-docker-in-docker:sha-e966463
```
This needs to be configured for spring initializer

## Restart Workshop
1. Open workshop terminal (in browwser)
2. Run the following command
  ```
  /opt/eduk8s/bin/rebuild-workshop
  ```

## Run Workshop 
```
make 
make open-workshop
```

## View workshop logs
1. Run and Open Workshop
2. In workshop terminal change directory to `~/.local/share/workshop`
3. Notice any files with extension `.failed`
4. Display contents of the corresponding log 

```
[~] $ cd ~/.local/share/workshop; ls
download-workshop.log   setup-scripts.failed  workshop-definition.json
kubernetes-settings.sh  setup-scripts.log     workshop-definition.yaml
[~/.local/share/workshop] $
[~/.local/share/workshop] $
[~/.local/share/workshop] $
[~/.local/share/workshop] $ cat setup-scripts.log 
+ local script=/opt/eduk8s/etc/setup.d/01-kubernetes.sh
+ echo 'Executing: /opt/eduk8s/etc/setup.d/01-kubernetes.sh'
Executing: /opt/eduk8s/etc/setup.d/01-kubernetes.sh
+ sh -x /opt/eduk8s/etc/setup.d/01-kubernetes.sh

...



+ cd /home/eduk8s/gemfire
/opt/packages/gemfire/setup.d/01-setup-user.sh: line 8: cd: /home/eduk8s/gemfire: No such file or directory
+ touch /home/eduk8s/.local/share/workshop/setup-scripts.failed
```


cd ~/.local/share/workshop; cat setup-scripts.log

## See files from packages in workshop terminal
```
cd /opt/packages/
```

# See ______ Logs
1. Open Computer Temrinal (not workshop)

2. Find the namespace of your workshop 
  ```
  % k get ns
  NAME                               STATUS   AGE
  default                            Active   2d21h
  educates                           Active   2d21h
  ...
  lab-mdas-base-w01                  Active   43s
  lab-mdas-base-w01-s001             Active   9s
  lab-mdas-base-w01-s001-vc          Active   8s
  ...
  ``` 

  **Note:** Your workshop namespace will end with `-w##` not `s##` or `s##-vc`
  **Suggestion:** Save it `export NS=lab-mdas-base-w01`

3. Find the pod associated with your workshop
  ```
  % k get pods -n $NS
  NAME                                      READY   STATUS    RESTARTS   AGE
  lab-mdas-base-w01-s001-6fb577b7d5-9lmt6   1/1     Running   0          2m39s
  ```
  
  **Suggestion:** Save it `export POD=lab-mdas-base-w01-s001-6fb577b7d5-9lmt6`

4. View Logs
  ```
  % k logs $POD -n $NS
  + set -eo pipefail
  + mkdir -p /home/eduk8s/.local/share/workshop
  + WORKSHOP_NAME=lab-mdas-base
  + TRAINING_PORTAL=lab-mdas-base
  + ENVIRONMENT_NAME=lab-mdas-base-w01
  + WORKSHOP_NAMESPACE=lab-mdas-base-w01
  + SESSION_NAMESPACE=lab-mdas-base-w01-s001
  + INGRESS_PROTOCOL=http
  + INGRESS_DOMAIN=192.168.0.15.nip.io
  + INGRESS_PORT_SUFFIX=
  + export WORKSHOP_NAME
  + export TRAINING_PORTAL
  + export ENVIRONMENT_NAME
  ...
  ```
  **Suggestion:** Write to file `echo $(k logs $POD -n $NS) > ~/Desktop/log.txt`
  **Suggestion:** Watch logs live `k logs $POD -n $NS --follow` (**Note:** You may have to run this a couple times until the container starts)
  **Suggestion:** One-liner `k logs $(k get pod -n $ns -o name) -n $ns --follow`

This repository holds templates for creating workshops to be hosted using
Educates. For detailed instructions on how to create workshops using these
templates see the [Educates
documentation](https://github.com/vmware-tanzu-labs/educates-docs).

Note that if creating a repository using GitHub's repository template feature,
you need to wait until the GitHub action triggered upon repository creation has
been run before creating a checkout of the repository. This is because the
GitHub action will rewrite the initial repository content with customized
workshop content.


