# syntax=docker/dockerfile:1
FROM python:alpine3.16 AS base
COPY ./docker/ansible/requirements.txt .
RUN pip3 install -r requirements.txt
WORKDIR home

# If you want to use what you built directly from the base image
FROM base AS prod
COPY ./ansible .

# If you don't want to build the base image
# you can use this image that is ready  
FROM jillesca/ansible:version1.0 as built
COPY ./ansible .

# build base image from ROOT dir
# docker build --target base --file docker/ansible/base-ansible.dockerfile --tag jillesca/ansible:version1.0 .

# run standalone
# docker run -dt --name ansible jillesca/ansible:version1.0

# log into the container
# docker exec -it ansible /bin/sh