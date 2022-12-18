# Network Automation

- [Network Automation](#network-automation)
- [Intro](#intro)
- [Lab used](#lab-used)
- [Create a lab](#create-a-lab)
  - [See ansible inventory](#see-ansible-inventory)

# Intro

I'm using this repo to practice some network automation codes, pipelines. As time passes I'm planning to add more functions/examples over time.

On this repo, you will find examples for:

- use ansible as a container
- use ansible to create a lab in Cisco Modelling Labs

> All commands added on the repo are assumming are being executed from the `ROOT` directory of the project, if you are not on the root directory, you need to update the paths if the commands are using it.

Every release on the repo, matches an article written in my personal blog. _Major changes between releases are introduced_, therefore if you follow the articles, **make sure you are looking at the corresponding release.** The Articles have links to their corresponded release.

So far the list of releases are:

- [Ansible in a Container](https://github.com/jillesca/network-automation/tree/v0.1.0)
  - See a detailed explanation [on my personal blog - Ansible in a Container](https://netcode.rocks/blog/ansible-container)
- [Automate network topologies with CML, Ansible & Docker.](https://github.com/jillesca/network-automation/tree/v1.0.0)
  - See a detailed explanation [on my personal blog - Automate network topologies with CML, Ansible & Docker.](https://netcode.rocks/blog/automate_topologies_with_ansible_cml_docker)

# Lab used

CML or [Cisco Modelling Labs](https://developer.cisco.com/docs/sandbox/#!networking/networking-overview) is used for this repo, the reason is because the `Devnet Sandbox` is free. Reserve a lab to get started.

# Create a lab

```
docker-compose -f ./docker/cml.docker-compose.yml up -d
docker exec -it cml /bin/sh
ansible-playbook cisco.cml.build -e startup='host'
```

## See ansible inventory

```
ansible-inventory --graph
```
