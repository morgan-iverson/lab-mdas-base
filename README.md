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


This repository holds templates for creating workshops to be hosted using
Educates. For detailed instructions on how to create workshops using these
templates see the [Educates
documentation](https://github.com/vmware-tanzu-labs/educates-docs).

Note that if creating a repository using GitHub's repository template feature,
you need to wait until the GitHub action triggered upon repository creation has
been run before creating a checkout of the repository. This is because the
GitHub action will rewrite the initial repository content with customized
workshop content.


