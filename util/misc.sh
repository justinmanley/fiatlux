#!/bin/bash

# curl
sudo apt-get install curl -y

# pass 
sudo apt-get install pass -y

# dropbox
# https://www.dropbox.com/install?os=lnx
# Don't want to run this as sudo
cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
~/.dropbox-dist/dropboxd

# f.lux
# https://justgetflux.com/linux.html
sudo add-apt-repository ppa:kilian/f.lux -y
sudo apt-get update -qq
sudo apt-get install fluxgui -y

# csvkit
sudo apt-get install python-dev python-pip python-setuptools build-essential
pip install csvkit