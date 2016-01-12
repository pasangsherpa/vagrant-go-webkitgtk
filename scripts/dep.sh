#!/bin/bash
#
# Setup the the box. This runs as root

apt-get -y update

# Install webkitgtk and golang
apt-get -y install libwebkit2gtk-3.0-dev golang

# Verify go is installed
go version && mkdir -p $HOME/go

# Setup go workspace, see https://golang.org/doc/code.html
grep '^export GOPATH' $HOME/.bashrc || echo "export GOPATH=$HOME/go" >> $HOME/.bashrc
grep '^export PATH' $HOME/.bashrc || echo "export PATH=$PATH:$HOME/go/bin" >> $HOME/.bashrc

# Install godep, see https://github.com/tools/godep
GOPATH=$HOME/go /usr/bin/go get github.com/tools/godep
