#!/bin/bash

# *********** Brew install ***********
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/brewuser/.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile 
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
brew -v
brew doctor

# *********** Install operator sdk ***********
brew install operator-sdk
# *********** Install kube-ps1 ***********
brew update
brew install kube-ps1
#sudo source "/home/linuxbrew/.linuxbrew/opt/kube-ps1/share/kube-ps1.sh" >> ~/.bash_profile
#echo 'PS1='$(kube_ps1)'$PS1' >> ~/.bash_profile
#source "/home/linuxbrew/.linuxbrew/opt/kube-ps1/share/kube-ps1.sh" >> ~/.profile 
#echo 'PS1='$(kube_ps1)'$PS1' >> ~/.profile 
# *********** Fix brew linux problem *********
go env -w CC=gcc CXX="g++"

# *********** Test operator sdk build bundle *
cd home
git clone https://github.com/thomassuedbroecker/multi-tenancy-frontend-operator
cd multi-tenancy-frontend-operator/frontendOperator
export REGISTRY='quay.io'
export ORG='tsuedbroecker'
export IMAGE='frontendcontroller:v3'
make bundle IMG="$REGISTRY/$ORG/$IMAGE"
