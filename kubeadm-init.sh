#!/bin/bash

cat <<EOF > kubeadm-init.yml
apiVersion: kubeadm.k8s.io/v1beta3
kind: InitConfiguration
nodeRegistration:
  kubeletExtraArgs:
    root-dir: "/k8sdata"
EOF

sudo kubeadm init \
--cri-socket unix:///var/run/cri-dockerd.sock \
--pod-network-cidr 10.244.0.0/16 \
--config kubeadm-init.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

