#!/bin/bash

# Bail if we are not running inside VirtualBox.
if [[ `facter virtual` != "virtualbox" ]]; then
    exit 0
fi

#!/bin/bash
apt-get -y install --no-install-recommends libdbus-1-3
aptitude -y install dkms
apt-get -y install virtualbox-guest-utils
sudo rm -rf VBoxGuestAdditions.iso