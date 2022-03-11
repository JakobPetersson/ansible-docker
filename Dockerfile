FROM python:3.9.6-slim-bullseye

# Install ssh
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ssh \
    sshpass

# Install Ansible
RUN pip install pip --upgrade
RUN pip install ansible

WORKDIR /work
