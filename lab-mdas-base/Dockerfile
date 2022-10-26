# This Dockerfile is used where you need to create a custom workshop base
# image which incorporates additional application binaries or tools. Select
# the appropriate Educates workshop base image in the `FROM` line.

FROM ghcr.io/vmware-tanzu-labs/educates-base-environment:2.0

# Include here any steps to build your custom workshop base image. See the
# documentation on best practices for building a custom workshop base image.

## HOMBREW ##

FROM ubuntu:xenial

RUN apt-get update \
	&& apt-get install -y --no-install-recommends software-properties-common \
	&& add-apt-repository -y ppa:git-core/ppa \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		bzip2 \
		ca-certificates \
		curl \
		file \
		fonts-dejavu-core \
		g++ \
		git \
		locales \
		make \
		openssh-client \
		patch \
		sudo \
		uuid-runtime \
	&& rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8 \
	&& useradd -m -s /bin/bash linuxbrew \
	&& echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
ADD . /home/linuxbrew/.linuxbrew/Homebrew
RUN cd /home/linuxbrew/.linuxbrew \
	&& mkdir -p bin etc include lib opt sbin share var/homebrew/linked Cellar \
	&& ln -s ../Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/ \
	&& chown -R linuxbrew: /home/linuxbrew/.linuxbrew \
	&& cd /home/linuxbrew/.linuxbrew/Homebrew \
	&& git remote set-url origin https://github.com/Linuxbrew/brew

USER linuxbrew
WORKDIR /home/linuxbrew
ENV PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
	SHELL=/bin/bash \
	USER=linuxbrew

# Install portable-ruby and tap homebrew/core.
RUN HOMEBREW_NO_ANALYTICS=1 HOMEBREW_NO_AUTO_UPDATE=1 brew tap homebrew/core \
	&& rm -rf ~/.cache

FROM redis
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

FROM postgres:14.3
RUN localedef -i de_DE -c -f UTF-8 -A /usr/share/locale/locale.alias de_DE.UTF-8
ENV LANG de_DE.utf8

# ...

# Uncomment the following if you wish to also copy workshop content files
# into the custom workshop base image, rather than workshop content files
# being published using a separate OCI image artefact or other mechanism.

# COPY --chown=1001:0 . /home/eduk8s/
# RUN mv /home/eduk8s/workshop /opt/workshop
# RUN fix-permissions /home/eduk8s
