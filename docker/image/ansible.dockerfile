# syntax=docker/dockerfile:1
FROM python:alpine3.16 AS base
COPY ./docker/image/requirements.txt .
RUN apk add \
    gcc \
    musl-dev \
    linux-headers \
    libssh-dev \
    openssh-client \
    && pip3 install -r requirements.txt
WORKDIR /home

# If you want to use what you built directly from the base image
FROM base AS prod
COPY ./ansible .

# If you don't want to build the base image
# you can use this image that is ready  
FROM jillesca/ansible:version1.1 as built
COPY ./ansible .

# Build a version to work with Cisco Modeling Labs or VIRL 
# virl2_client lib is linked to the controller version.
# virl version used was 2.2.2+build52
# If your virl version is different, this must be updated.
# Check your version with curl or open the API on your browser.
# curl https://{CML_IP}/api/v0/system_information -k
# https://github.com/CiscoDevNet/virl2-client/issues/20#issuecomment-1181432957
FROM jillesca/ansible:version1.1 as cml
RUN pip install virl2-client==2.2.1.post2 \
    && ansible-galaxy collection install cisco.cml

# build base image from ROOT dir
# docker build --target base --file docker/image/ansible.dockerfile --tag jillesca/ansible:version1.1 .

# run standalone
# docker run -dt --name ansible jillesca/ansible:version1.1

# log into the container
# docker exec -it ansible /bin/sh