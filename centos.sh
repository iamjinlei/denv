#!/bin/bash

set -e
set -x

VIM_VERSION="8.1.0996"

# tools
yum install -y git tmux gcc-c++ ncurses-devel python-devel

mkdir -p ~/tmp

# vim for centos 7.6
pushd ~/tmp && wget https://github.com/vim/vim/archive/v$VIM_VERSION.tar.gz && tar zxvf v$VIM_VERSION.tar.gz && cd vim-$VIM_VERSION/src && make && make install && popd
echo "alias vi=\"vim\"" >> ~/.bash_profile

# tmux
pushd ~/tmp && wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz && tar zxvf libevent-2.0.21-stable.tar.gz && cd libevent-2.0.21-stable && ./configure && make && make install && popd
pushd ~/tmp && wget https://github.com/tmux/tmux/releases/download/2.4/tmux-2.4.tar.gz && tar zxvf tmux-2.4.tar.gz && cd tmux-2.4 && ./configure && make && make install && popd

# go
pushd ~/tmp && wget https://dl.google.com/go/go1.11.4.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.11.4.linux-amd64.tar.gz && popd
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bash_profile && echo "export GOPATH=/root/go" >> ~/.bash_profile && source ~/.bash_profile

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
pushd ~/ && git clone https://github.com/gpakosz/.tmux.git && ln -s -f .tmux/.tmux.conf && cp .tmux/.tmux.conf.local . && popd

curl -LSso ~/tmp/tmux.conf https://raw.githubusercontent.com/iamjinlei/env/master/tmux.conf && cat ~/tmp/tmux.conf >> ~/.tmux.conf.local

rm -rf ~/tmp
