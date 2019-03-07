#!/bin/bash

set -e
set -x

# tools
yum install -y git tmux vim

# go
pushd ~/ && wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz && rm go1.11.4.linux-amd64.tar.gz && echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile && echo "export GOPATH=/root/go" >> ~/.bash_profile && source ~/.bash_profile && popd 

# pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim 
