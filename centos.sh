#!/bin/bash

set -e
set -x

# tools
yum install -y git tmux gcc-c++ ncurses-devel python-devel

# vim 8+ for centos 7.6
pushd ~/ && git clone https://github.com/vim/vim.git && pushd vim/src && make && make install && popd && rm -rf vim && popd 
echo "alias vi=\"vim\"" >> ~/.bash_profile

# go
pushd ~/ && wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz && rm go1.11.4.linux-amd64.tar.gz && echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile && echo "export GOPATH=/root/go" >> ~/.bash_profile && source ~/.bash_profile && popd 

# pathogen vim runtime path management
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# .vimrc
curl -LSso ~/.vimrc https://raw.githubusercontent.com/iamjinlei/env/master/vimrc

# vim-colors-solarized
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized

# vim-go
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
vim +GoInstallBinaries +qall 

# .tmux.conf
curl -LSso ~/.tmux.conf https://raw.githubusercontent.com/iamjinlei/env/master/tmux.conf
