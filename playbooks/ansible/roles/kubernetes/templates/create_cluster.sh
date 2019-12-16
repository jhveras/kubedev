#!/bin/bash

LOCAL_IPADDR=$(ip addr | grep eth1 -A 5 | grep inet | grep -v inet6 | awk '{ print $2 }' | cut -f1 -d"/")

if [[ ! -f /home/vagrant/.kube/config ]]; then
  echo "Initiating kubernetes cluster"
  # System tasks
  sudo swapoff -a
  sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
  sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=${LOCAL_IPADDR} --kubernetes-version=v1.17.0
  
  # Preparing user to use cluster
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
  export KUBECONFIG=$HOME/.kube/config
  
  # Configuring kubernetes networking
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
  kubectl taint nodes --all node-role.kubernetes.io/master-
fi

exit 0
