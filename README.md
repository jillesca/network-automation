# Network Automation

- [Network Automation](#network-automation)
  - [Intro](#intro)
  - [Build and use Ansible on a Container](#build-and-use-ansible-on-a-container)
  - [Reserve a lab (optional)](#reserve-a-lab-optional)
  - [Github Runner](#github-runner)

## Intro

I'm using this repo to practice some network automation codes, pipelines. As time passes I'm planning to add more functions/examples over time.

On this repo, you will find examples for:

- use ansible to configure network devies
- use ansible as a container
- use ansible as part of a pipeline

## Build and use Ansible on a Container

build docker image from root dir

```bash
docker build --file ansible-dockerfile/base-ansible.dockerfile --tag jillesca/ansible:version1.0 .
```

run container standalone

```bash
docker run -dt --name ansible jillesca/ansible:version1.0 /bin/sh
```

log into the container

```bash
docker exec -it ansible /bin/sh
```

from there you can verify the ansible installation

```bash
/ # ansible --version
ansible [core 2.13.5]
  config file = None
  configured module search path = ['/root/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/local/lib/python3.10/site-packages/ansible
  ansible collection location = /root/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/local/bin/ansible
  python version = 3.10.8 (main, Oct 13 2022, 23:21:19) [GCC 11.2.1 20220219]
  jinja version = 3.1.2
  libyaml = False
/ #
```

## Reserve a lab (optional)

If you don't have network devices available, and you want to follow the example, you can reserve a `Cisco DevNet Sandbox`, which is free.

For this guide I used [Cisco Modeling Labs Enterprise](https://developer.cisco.com/docs/sandbox/#!networking/networking-overview)

Follow the instructions about reserving the lab.

## Github Runner

For the pipeline, I'm using `Github Actions`, therefore the instructions on the repo are specific for Github, however you can replicate the concepts on other CI/CD tools.

I'm using a self-hosted runner, so my pipeline can reach and configure the network devices inside a VPN. for this guide the runner is configured in my laptop.

To add a runner go to:
`Settings > Actions > Runners` and click on `New self-hosted runner`. From there chose your OS and follow the instructions.

Once the runner is added, you can see its status on the runner tab.
