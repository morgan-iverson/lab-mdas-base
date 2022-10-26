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

Run Workshop 
```
make 
make open-workshop
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
