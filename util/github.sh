#!/bin/bash

# install and configure git
sudo apt-get install git -y
git config --global user.email "${GITCONFIG[EMAIL]}"
git config --global user.name "${GITCONFIG[NAME]}"

# install hub tool
git clone https://github.com/github/hub.git
cd hub
./script/build
sudo cp hub /usr/local/bin
cd ../ && rm -rf hub # cleanup

# add goodies like summaries of repo stats, etc.
sudo apt-get install git-extras -y

# alias hub as git
printf '\n# alias hub as git \neval "$(hub alias -s)"' >> ~/.bash_profile
