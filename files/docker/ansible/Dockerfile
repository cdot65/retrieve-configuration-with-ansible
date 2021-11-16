FROM alpine:3.11

### -------------------------------------------------
### Metadata information
### -------------------------------------------------
LABEL name="ansible-vxlan-evpn-crb-datacenter"
LABEL maintainer="cremsburg@protonmail.com"
LABEL description="ansible container to manage juniper data centers"
LABEL license="GPLv3"
LABEL url="https://gitlab.com/cremsburg/juniper-automation-container/container_registry"
LABEL build-date="20210123"

### -------------------------------------------------
### Install system Package
### -------------------------------------------------
RUN apk --update --no-cache add \
      ca-certificates \
      git \
      libxml2 \
      libxml2-dev \
      libxslt \
      libxslt-dev \
      openssh-client \
      openssl \
      python3\
      rsync \
      sshpass

### -------------------------------------------------
### Install additional dependencies
### -------------------------------------------------
RUN apk --update add --virtual \
        .build-deps \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base

### -------------------------------------------------
### Upgrade pip
### -------------------------------------------------
RUN pip3 install --upgrade \
        pip \
        cffi

### -------------------------------------------------
### Change directory to /home/tmp
### -------------------------------------------------
WORKDIR /home/tmp/files

### -------------------------------------------------
### Add and install python packages
### -------------------------------------------------
ADD config/requirements.txt requirements.txt
RUN pip install -U pip
RUN pip install -r requirements.txt
RUN pip install --upgrade pip

### -------------------------------------------------
### Install Ansible Galaxy roles
### -------------------------------------------------
RUN ansible-galaxy install juniper.junos -p ~/.ansible/roles

### -------------------------------------------------
### Copy local files to container
### -------------------------------------------------
COPY config/ansible.cfg /etc/ansible/ansible.cfg
COPY config/jsnapy.cfg /etc/jsnapy/jsnapy.cfg

### -------------------------------------------------
### Environmentals
### -------------------------------------------------
ENV ANSIBLE_CONFIG /etc/ansible/ansible.cfg

### -------------------------------------------------
### Cleanup work
### -------------------------------------------------
RUN apk del .build-deps 
RUN rm -rf /var/cache/apk/*