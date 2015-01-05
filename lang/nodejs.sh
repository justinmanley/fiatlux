#!/bin/bash

source setup/config.sh

# install nvm 
sudo apt-get install build-essential libssl-dev -y
curl https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh

# need to close and reopen terminal to start using nvm
source ~/.bash_profile

# install nodejs
nvm install ${VERSION["NODEJS"]} # or more recent version - use nvm ls-remote
nvm use ${VERSION["NODEJS"]}
nvm alias default 0.11.13

# get the latest version of npm
npm install -g npm

# install global dependencies
npm install -g grunt-cli
npm install -g bower

# facebook flow
curl http://flowtype.org/downloads/flow-linux64-latest.zip -LO
unzip flow-linux64-latest.zip
sudo chown root flow
sudo chgrp root flow

if [ ! -d "/usr/share/flow" ]; then
	sudo mv flow /usr/share/flow
else
	echo "Error installing facebook flow: /usr/share/flow is already a directory."
fi

if [ ! -e "/usr/bin/flow" ]; then
	sudo ln -s "/usr/share/flow/flow" "/usr/bin/flow"
else
	echo "Error installing facebook flow: /usr/bin/flow already exists."
fi
