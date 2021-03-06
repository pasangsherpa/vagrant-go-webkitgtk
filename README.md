# vagrant-go-webkitgtk
> Vagrant box of Ubuntu 14.04 (64 bit) with [Golang](https://golang.org/), [godep](https://godoc.org/github.com/tools/godep), [WebKitGTK+](http://webkitgtk.org/), and [webloop](https://github.com/pasangsherpa/webloop)

### Installation

1. Install [Vagrant](https://www.vagrantup.com) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads)

2. Pull box from repo 

        $ vagrant init pasangsherpa/go-webkitgtk
        $ vagrant up --provider virtualbox


3. Alternatively, you can build the box using [packer](https://www.packer.io/intro/getting-started/setup.html): 
    
    	// base box to build on top of
    	$ vagrant box add boxcutter/ubuntu1404 --provider virtualbox

    	$ git clone git@github.com:pasangsherpa/vagrant-go-webkitgtk.git
        $ cd vagrant-go-webkitgtk
        $ packer build ubuntu-14.04-amd64.json

        $ vagrant box add go-webkitgtk ubuntu-14.04.virtualbox.box
        $ vagrant init go-webkitgtk
        $ vagrant up --provider virtualbox
