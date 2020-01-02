#!/bin/bash

DOCKER_CONTAINER_NAME1="ansible-role-test1"
DOCKER_CONTAINER_NAME2="ansible-role-test2"
DOCKER_CONTAINER_NAME3="ansible-role-test3"
SSH_PUBLIC_KEY=/home/user/.ssh/id_rsa.pub

docker run -dt --privileged=true -p 8080:80 -p 8443:443 -p 5001:22 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name "$DOCKER_CONTAINER_NAME1" -e AUTHORIZED_KEYS="$SSH_PUBLIC_KEY" centos8-systemd:latest

docker run -dt --privileged=true -p 5002:22 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name "$DOCKER_CONTAINER_NAME2" -e AUTHORIZED_KEYS="$SSH_PUBLIC_KEY" centos8-systemd:latest

docker run -dt --privileged=true -p 5003:22 -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name "$DOCKER_CONTAINER_NAME3" -e AUTHORIZED_KEYS="$SSH_PUBLIC_KEY" centos8-systemd:latest
