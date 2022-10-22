# network-automation

Some network automation codes, pipelines that I'm planning to add over time

On this repo, you will find examples for:

- use ansible to configure network devies
- use ansible as a container
- use ansible as part of a pipeline

# Build and Use ansible on a container

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
