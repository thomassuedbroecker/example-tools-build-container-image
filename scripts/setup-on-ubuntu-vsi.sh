#!/bin/bash

# ********** Basics needed ************
apt-get -q update
apt-get -y upgrade
apt-get --assume-yes install apt-transport-https
apt-get --assume-yes install ca-certificates 
apt-get --assume-yes install curl 
apt-get --assume-yes install software-properties-common
apt-get --assume-yes install gnupg-agent 
apt-get --assume-yes install python-minimal 
apt-get --assume-yes install jq
apt-get --assume-yes install make
apt-get --assume-yes install git-core
apt-get --assume-yes install nano
apt-get --assume-yes install build-essential
apt-get --assume-yes install einstall numactl
apt-get --assume-yes install qemu-system-x86-64
apt-get --assume-yes install podman

# ************ Buildah apt-get *********
. /etc/os-release
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo apt-get update -qq
sudo apt-get -qq --assume-yes install buildah

# *********** Kubernetes ***************
apt-get update
apt-get --assume-yes install apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list 
apt-get update
apt-get --assume-yes install kubectl

# *********** Docker community addition ***
# Install docker community addition
echo "127.0.0.1 localhost" > /etc/hosts
sysctl -w vm.max_map_count=262144
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab
echo "vm.max_map_count=262144" >> /etc/sysctl.conf
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get -q update
apt-get --assume-yes install docker-ce docker-ce-cli containerd.io
start docker.service
docker version
chmod 666 /var/run/docker.sock

# *********** IBM Cloud CLI *********** 
curl -fsSL https://clis.cloud.ibm.com/install/linux | sh 
ibmcloud plugin install container-service 
ibmcloud plugin install container-registry 
ibmcloud plugin install code-engine 
ibmcloud plugin install cloud-databases

# *********** Brew user ***********
mkdir brewuser
cd ..
groupadd brewusers 
useradd -G brewusers brewuser 
usermod -a -G  brewusers root 
usermod -a -G  root brewuser
chown -R brewuser:brewusers home
chown -R brewuser:brewusers home/brewuser
chmod g+rwX home
chmod g+rwX home/brewuser
chsh -s /bin/bash brewuser
cd home
echo "brewuser:password"|chpasswd
su - brewuser
whoami
pwd
cd ..
