#!/bin/bash

if [ ! -f /etc/yum.repos.d/docker-ce.repo ]; then
  yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
fi

exit 0
