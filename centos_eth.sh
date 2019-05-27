#!/bin/bash

#
# This script installs basic ethereum development tool chains for CentOs system
#

set -e
set -x

mkdir -p ~/tmp

pushd ~/tmp && curl -sL https://rpm.nodesource.com/setup_10.x | bash && yum install -y nodejs && popd
# npm install ganache-cli web3@1.0.0-beta.37
