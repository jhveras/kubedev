#!/bin/bash

wget https://get.helm.sh/helm-v3.6.2-linux-amd64.tar.gz
tar xvf helm-v3.6.2-linux-amd64.tar.gz -C /tmp/
sudo mv /tmp/linux-amd64/helm /usr/local/bin/helm
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add dagster https://dagster-io.github.io/helm