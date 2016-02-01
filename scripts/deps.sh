#!/bin/sh -eux

# Install wekitgtk
apt-get -y install --no-install-recommends -yq \
	git \
	libwebkit2gtk-3.0-dev \
	libgtk-3-dev \
	libcairo2-dev

# Variables
go_version="go1.5"
tar_gz="linux-amd64.tar.gz"

# Install golang
wget https://storage.googleapis.com/golang/${go_version}.${tar_gz} -o /tmp/${go_version}.${tar_gz}
tar -zxvf ${go_version}.${tar_gz} -C /usr/local
rm ${go_version}.${tar_gz}

# Setup go workspace, see https://golang.org/doc/code.html
mkdir -p $HOME/go
grep '^export GOPATH' $HOME/.bashrc || echo "export GOPATH=$HOME/go" >> $HOME/.bashrc
grep '^export PATH' $HOME/.bashrc || echo "export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin" >> $HOME/.bashrc

# Install godep, see https://github.com/tools/godep
GOPATH=$HOME/go /usr/local/go/bin/go get github.com/tools/godep
GOPATH=$HOME/go /usr/local/go/bin/go get -u -tags gtk_3_10 github.com/pasangsherpa/webloop/...