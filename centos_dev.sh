#!/bin/bash

#
# This script installs basic development tool chains for CentOs system
#

set -e
set -x

OS=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
GO_VERSION="1.11.4"
VIM_VERSION="8.1.0996"
TMUX_VERSION="2.8"

# tools
if [ $OS = "CentOS Linux" ]; then
    yum install -y git gcc-c++ ncurses-devel python-devel libevent-devel
elif [ $OS = "Ubuntu" ]; then
    apt-get update
    add-apt-repository ppa:ubuntu-toolchain-r/test
    apt-get update
    apt-get install -y git g++-4.9 build-essential libncurses5-dev libncursesw5-dev python-dev libevent-dev
else
    echo "unsupported OS!"
    exit
fi

mkdir -p ~/tmp

# go
pushd ~/tmp && wget https://dl.google.com/go/go$GO_VERSION.linux-amd64.tar.gz && tar -C /usr/local -xzf go$GO_VERSION.linux-amd64.tar.gz && popd

# vim for centos 7.6
pushd ~/tmp && wget https://github.com/vim/vim/archive/v$VIM_VERSION.tar.gz && tar zxvf v$VIM_VERSION.tar.gz && cd vim-$VIM_VERSION/src && make && make install && popd

# pathogen vim runtime path management
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# .vimrc
curl -LSso ~/.vimrc https://raw.githubusercontent.com/iamjinlei/env/master/vimrc

# vim-colors-solarized
git clone https://github.com/altercation/vim-colors-solarized.git ~/.vim/bundle/vim-colors-solarized
# vim status line
git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
git clone https://github.com/vim-airline/vim-airline-themes.git ~/.vim/bundle/vim-airline-themes

# vim-go
git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go

# tmux
pushd ~/tmp && wget https://github.com/tmux/tmux/releases/download/$TMUX_VERSION/tmux-$TMUX_VERSION.tar.gz && tar zxvf tmux-$TMUX_VERSION.tar.gz && cd tmux-$TMUX_VERSION && ./configure && make && make install && popd

# tmux conf
pushd ~/ && git clone https://github.com/gpakosz/.tmux.git && ln -s -f .tmux/.tmux.conf && cp .tmux/.tmux.conf.local . && popd
curl -LSso ~/tmp/tmux.conf https://raw.githubusercontent.com/iamjinlei/env/master/tmux.conf && cat ~/tmp/tmux.conf >> ~/.tmux.conf.local

# enable tmux powerline symbol
sed -i.bk 's/tmux_conf_theme_left_separator_main/#tmux_conf_theme_left_separator_main/g; s/tmux_conf_theme_left_separator_sub/#tmux_conf_theme_left_separator_sub/g; s/tmux_conf_theme_right_separator_main/#tmux_conf_theme_right_separator_main/g; s/tmux_conf_theme_right_separator_sub/#tmux_conf_theme_right_separator_sub/g' ~/.tmux.conf.local
sed -i.bk 's/##tmux_conf_theme_left_separator_main/tmux_conf_theme_left_separator_main/g; s/##tmux_conf_theme_left_separator_sub/tmux_conf_theme_left_separator_sub/g; s/##tmux_conf_theme_right_separator_main/tmux_conf_theme_right_separator_main/g; s/##tmux_conf_theme_right_separator_sub/tmux_conf_theme_right_separator_sub/g' ~/.tmux.conf.local

# generate pub key
ssh-keygen -f ~/.ssh/id_rsa -t rsa -N ''

rm -rf ~/tmp

# bash env
echo "export GOPATH=/root/go" >> ~/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.bash_profile
echo "export EDITOR=vim" >> ~/.bash_profile

echo "alias vi='vim'" >> ~/.bash_profile
echo "alias gshow='git show --color'" >> ~/.bash_profile
echo "alias gamend='git commit --amend'" >> ~/.bash_profile
echo "alias gdiff='git diff --color'" >> ~/.bash_profile
echo "alias rm='rm -i'" >> ~/.bash_profile
echo "alias grep='grep --color=always'" >> ~/.bash_profile

source ~/.bash_profile

vim +GoInstallBinaries +qall
