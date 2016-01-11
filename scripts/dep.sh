#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update

# Install webkitgtk and golang
apt-get -y install libwebkit2gtk-3.0-dev golang

# Add Go bin dir to path
echo export PATH=\\\$PATH:/usr/local/go/bin >> /etc/profile

# Load profile to get the updated PATH
source /etc/profile

# Setup go workspace, see https://golang.org/doc/code.html
grep '^export GOPATH' ~/.bashrc || echo export GOPATH=~/go >> ~/.bashrc
grep '^export PATH' ~/.bashrc || echo export PATH=\\\$PATH:~/go/bin >> ~/.bashrc
    
# Load bashrc to get the new GOPATH and the updated PATH
source ~/.bashrc

# Install godep, see https://github.com/tools/godep
GOPATH=~/go /usr/local/go/bin/go get github.com/tools/godep
