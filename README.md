# Ansible Download Configs

## Overview

`Ansible Download Configs` is hopefully self-explanatory: an easier way to download configurations over NETCONF.

This project is based on *[Infrastructure-As-Code](https://dev.to/fedekau/infrastructure-as-code-a-beginners-perspective-2l8k)* concepts, where all elements of a device's configuration as stored in a format of `key:value` pairs and stored in a source-code management system such as Github or Gitlab. While not required for successful deployments, we at Juniper encourage network devops teams to *[leverage best practicies with git](https://dev.to/bholmesdev/git-github-best-practices-for-teams-opinionated-28h7)*.

## How to use this project

The crux of this project is to download the device configurations locally by executing the *[files/ansible/pb.configuration.build.yml](files/ansible/pb.configuration.download.yml)* playbook, found in the `files/ansible` directory. Taking a peek at this relatively simple workflow, we can see that there are just three tasks executed:

>1. build local directories that hold our configurations
>2. reach out to the network devices over NETCONF, grab the config
>3. store output of command in text format to our local directories

## New Features

- `Makefile` included to shortcut many of the commands
- Docker container provided for those that want execute in an isolated environment.

## Execution

The execution of this playbook can be achieved in multiple ways, experiment with each to find out your organization's preference. As you will see throughout the documentation, we have provided a `Makefile` to act as a shortcut for many of our project's commands.

### Running inside a Docker container

This is a personal preference, but this is a very clean method to run the playbook as it already manages all of your Python package dependencies. Within the root directory, you will run two commands to build and run the dedicated docker container.

#### Building the Ansible container

This command will build the container image to be used by ansible

```sh
make build
```

> *note: the `make build` command only needs to be run once; subsequent executions of the command will not hurt anything, but will add a second or two of wasted time*

#### Downloading the configurations only

If you would only like to build the configurations to your local machine, and hold off on applying them to your live networking devices, run this command:

```sh
make download
```

## Project dependencies

You may not be surprised to learn that you'll need Docker installed on your local workstation. That's it!

*[Docker](https://docs.docker.com/get-docker/)*

This requirement is an obvious moot point if you're using Ansible Tower to execute through a GUI.

### Optional

Protect your `secrets.yml` file by *[using Ansible-Vault to encrypt it with a password](https://docs.ansible.com/ansible/latest/user_guide/vault.html)*.

`ansible-vault encrypt group_vars/all/secrets.yml`

## Development

Want to contribute? Great!

Submit a PR and let's work on this together :D
