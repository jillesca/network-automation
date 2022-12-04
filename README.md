# Network Automation

- [Network Automation](#network-automation)
  - [Intro](#intro)
  - [Build and use Ansible on a Container](#build-and-use-ansible-on-a-container)
  - [Reserve a lab (optional)](#reserve-a-lab-optional)
  - [Github Runner](#github-runner)
  - [managing cml on ansible](#managing-cml-on-ansible)
    - [Clean a lab](#clean-a-lab)
    - [Create a lab](#create-a-lab)
    - [See ansible inventory](#see-ansible-inventory)
    - [See CML inventory](#see-cml-inventory)
  - [Create ssh keys](#create-ssh-keys)

## Intro

I'm using this repo to practice some network automation codes, pipelines. As time passes I'm planning to add more functions/examples over time.

On this repo, you will find examples for:

- use ansible to configure network devies
- use ansible as a container
- use ansible as part of a pipeline

> All commands added on the repo are assumming are being executed from the `ROOT` directory of the project, if you are not on the root directory, you need to update the paths if the commands are using it.

## Build and use Ansible on a Container

build docker image from root dir. Tag name is optional, but must be referenced when use `docker run`.

```bash
# Build
docker build --file ansible-dockerfile/base-ansible.dockerfile --tag jillesca/ansible:version1.0 .

# run container standalone
docker run -dt --name ansible jillesca/ansible:version1.0

# log into the container
docker exec -it ansible /bin/sh

# Verify the ansible installation
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

For an easier way to develop with the container, use docker-compose. This way, changes on your local project will be reflected on the container.

```bash
# Bring container
docker-compose -f ./docker/ansible.docker-compose.yml up -d

# log into the container
docker exec -it ansible /bin/sh

# Two ways to bring down the container, prefer first option
docker-compose -f ./docker/ansible.docker-compose.yml down
docker rm -f ansible
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

## managing cml on ansible

### Clean a lab

If you want to specify the lab to wipe

_tip_: if you have spaces in your lab name use double quotations, example: `'` inside `""`

```
ansible-playbook cisco.cml.clean -e cml_lab="'Small NXOS/IOSXE Network'"
```

Or if have the lab specified on the `cml_lab` env var.

```
ansible-playbook cisco.cml.clean
```

### Create a lab

```
ansible-playbook cisco.cml.build -e startup='host'
```

### See ansible inventory

```
ansible-inventory --graph
```

### See CML inventory

```
ansible-playbook cisco.cml.inventory
```

## Create ssh keys

Enter into the container

```bash
docker exec -it cml /bin/sh
```

```bash
ssh-keygen -f /home/.ssh/cml -t ed25519 -C 'CML_Automation_key' -N ''
cp /home/.ssh/cml.pub /home/.ssh/authorized_keys
```

copy the keys to the VM

At the time of writing the VM on the Cisco sandbox uses the IP `10.10.20.50`. Replace this IP with the address of the host you want to use as bastion.

```bash
scp /home/.ssh/authorized_keys developer@10.10.20.50:/home/developer/.ssh
```

Start your ssh-agent and add your keys

```bash
eval $(ssh-agent -s)
ssh-add /home/.ssh/cml
```

test

```bash
ssh developer@10.10.20.50
```
