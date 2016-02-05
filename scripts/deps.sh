#!/bin/sh -eux

# Install wekitgtk
apt-get -y install --no-install-recommends -yq \
    git \
    libwebkit2gtk-3.0-dev \
    libgtk-3-dev \
    libcairo2-dev \
    xvfb

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

# Install webloop (Scriptable, headless WebKit with a Go API), see https://github.com/pasangsherpa/webloop
GOPATH=$HOME/go /usr/local/go/bin/go get -u -tags gtk_3_10 github.com/pasangsherpa/webloop/...

# Add xvfb init script
cat >/etc/init/xvfb.conf <<EOL
description "xvfb init"
start on vagrant-mounted
stop on runlevel [!2345]

script
    DISPLAY=:0.0
    XVFB=/usr/bin/Xvfb
    XVFBARGS="\$DISPLAY -ac -screen 0 1024x768x16 +extension RANDR"
    PIDFILE="/var/xvfb.pid"

    echo "export DISPLAY=\$DISPLAY" >> /home/vagrant/.bashrc

    exec >/var/log/upstart/xvfb.log 2>&1
    exec /sbin/start-stop-daemon --start --quiet --pidfile \$PIDFILE --make-pidfile --background --exec \$XVFB -- \$XVFBARGS
end script
EOL
