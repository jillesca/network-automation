# https://learn.microsoft.com/en-us/azure/developer/ansible/configure-in-docker-container?tabs=azure-cli

FROM python:alpine3.16

COPY . .

RUN pip3 install -r ansible-dockerfile/requirements.txt

# build image from root dir
# docker build --file ansible-dockerfile/base-ansible.dockerfile --tag jillesca/ansible:version1.0 .

# run standalone
# docker run -dt --name ansible jillesca/ansible:version1.0 /bin/sh

# log into the container
# docker exec -it ansible /bin/sh