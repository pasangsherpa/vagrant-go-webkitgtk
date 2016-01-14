#!/bin/sh -eux

# Install wekitgtk
apt-get -y install libwebkit2gtk-3.0-dev

# Variables
go_version="go1.5";
tar_gz="linux-amd64.tar.gz"

# Install golang
wget https://storage.googleapis.com/golang/${go_version}.${tar_gz} -o /tmp/${go_version}.${tar_gz}
tar -zxvf ${go_version}.${tar_gz} -C /usr/bin/
rm ${go_version}.${tar_gz}

# Verify go is installed
go version && mkdir -p $HOME/go

# Setup go workspace, see https://golang.org/doc/code.html
grep '^export GOPATH' $HOME/.bashrc || echo "export GOPATH=$HOME/go" >> $HOME/.bashrc
grep '^export PATH' $HOME/.bashrc || echo "export PATH=$PATH:$HOME/go/bin" >> $HOME/.bashrc

# Install godep, see https://github.com/tools/godep
GOPATH=$HOME/go go get github.com/tools/godep