#!/bin/bash

# *********** Brew install ***********
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/brewuser/.
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew -v
brew doctor

# *********** Install operator sdk ***********
brew install operator-sdk
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
