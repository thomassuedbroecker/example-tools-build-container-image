FROM docker.io/ubuntu:22.04

# buildah
# *********************************************************o
RUN apt-get update -qq \
    && apt-get --assume-yes install buildah \
    && apt-get --assume-yes install iptables

# Java
# *********** default-jdk -> openjdk-11-jdk ***************
RUN apt update \
    && apt-get --assume-yes install default-jdk

# *********** Basic tools *************** 
RUN apt-get update \
    && apt-get --assume-yes install curl \
    && apt-get --assume-yes install git-core \
    && apt-get --assume-yes install wget \
    && apt-get --assume-yes install gnupg2 \
    && apt-get --assume-yes install nano \
    && apt-get --assume-yes install apt-utils \
    && apt-get --assume-yes install unzip \
    && apt-get --assume-yes install zip \
    && apt-get --assume-yes install sed \
    && apt-get --assume-yes install jq \
    && apt-get --assume-yes install original-awk \
    && apt-get --assume-yes install make \
    && apt-get --assume-yes install software-properties-common \
    && apt-get --assume-yes install build-essential \
    && apt-get --assume-yes install sudo \
    && apt-get --assume-yes install bash 

# Kubernetes
# *********** Kubernetes ***************
RUN apt-get update && apt-get install -y apt-transport-https \
    && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
    && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
    && apt-get update \
    && apt-get --assume-yes install kubectl

# *********** IBM Cloud CLI *********** 
RUN  curl -fsSL https://clis.cloud.ibm.com/install/linux | sh \
     && ibmcloud plugin install container-service \
     && ibmcloud plugin install container-registry \
     && ibmcloud plugin install code-engine \
     && ibmcloud plugin install cloud-databases

RUN groupadd brewusers \
    && useradd -G brewusers brewuser \
    && usermod -a -G  brewusers root \
    && chown -R brewuser:brewusers home \
    && chmod g+rwX home

RUN echo "brewuser:password"|chpasswd
RUN echo "root:password"|chpasswd

USER brewuser

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
