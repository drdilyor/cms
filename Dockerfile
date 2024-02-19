# syntax=docker/dockerfile:1
FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y \
    build-essential \
    cgroup-lite \
    cppreference-doc-en-html \
    git \
    libcap-dev \
    libcups2-dev \
    libffi-dev \
    libpq-dev \
    libyaml-dev \
    postgresql-client \
    python3-pip \
    python3.8 \
    python3.8-dev \
    sudo \
    vim \
    wait-for-it \
    zip

# Create cmsuser user with sudo privileges
RUN useradd -ms /bin/bash cmsuser && \
    usermod -aG sudo cmsuser
# Disable sudo password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
# Set cmsuser as default user
USER cmsuser

RUN mkdir /home/cmsuser/cms
COPY --chown=cmsuser:cmsuser requirements.txt dev-requirements.txt /home/cmsuser/cms/

WORKDIR /home/cmsuser/cms

RUN sudo pip3 install -r requirements.txt

COPY --chown=cmsuser:cmsuser . /home/cmsuser/cms

RUN sudo python3 setup.py install

RUN sudo python3 prerequisites.py --yes --cmsuser=cmsuser install

ENV LANG C.UTF-8

CMD [""]
