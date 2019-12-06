#!/bin/bash
# Section 2

cidr=$1
tmpDir=/tmp
join=${tmpDir}/join.tmp


# install docker
apt install docker.io
systemctl enable docker

# add kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt-get install kubeadm kubelet kubectl
apt-mark hold kubeadm kubelet kubectl

# open firewall
ufw allow 2379:2380,6443,10250:10255/tcp

# Kubernetes init
if [ -z $CIDR ]
then
	# Network wasnt set use default
	kubeadm init --pod-network-cidr=10.244.0.0/16 | grep -A1 kubeadm > ${join}
else
	# was set
	kubeadm init --pod-network-cidr=${cidr} | grep -A1 kubeadm > ${join}
fi

# Task 1
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Task 2
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Task 3
printf "Add worker nodes to the cluster by running:\n\n"
cat ${join}
printf "\nPress any Enter When Ready to Continue\n"
while [ true ] ; do
        read -t 30 -n 1
        if [ $? = 0 ] ; then
        exit ;
fi
done


# Deploy MetalLB
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.8.3/manifests/metallb.yaml
kubectl apply -f https://raw.githubusercontent.com/antimodes201/k8s-demo/master/metallb-configmap.yaml

# Deploy Helm
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get | bash
kubectl --namespace kube-system create serviceaccount tiller
helm init --service-account tiller --wait
