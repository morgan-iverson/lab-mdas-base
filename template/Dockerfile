(@ load("@ytt:data", "data") -@)

# This Dockerfile is used where you need to create a custom workshop base
# image which incorporates additional application binaries or tools. Select
# the appropriate Educates workshop base image in the `FROM` line.

(@ if data.values.workshop.image == "jdk8-environment:*": -@)
FROM ghcr.io/vmware-tanzu-labs/educates-jdk8-environment:2.0
(@- elif data.values.workshop.image == "jdk11-environment:*": -@)
FROM ghcr.io/vmware-tanzu-labs/educates-jdk11-environment:2.0
(@- elif data.values.workshop.image == "conda-environment:*": -@)
FROM ghcr.io/vmware-tanzu-labs/educates-conda-environment:2.0
(@- else: -@)
FROM ghcr.io/vmware-tanzu-labs/educates-base-environment:2.0
(@- end @)

# Include here any steps to build your custom workshop base image. See the
# documentation on best practices for building a custom workshop base image.

# ...

# Uncomment the following if you wish to also copy workshop content files
# into the custom workshop base image, rather than workshop content files
# being published using a separate OCI image artefact or other mechanism.

# COPY --chown=1001:0 . /home/eduk8s/
# RUN mv /home/eduk8s/workshop /opt/workshop
# RUN fix-permissions /home/eduk8s
