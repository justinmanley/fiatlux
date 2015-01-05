#!/bin/bash

# spotify
sudo apt-add-repository -y "deb http://repository.spotify.com stable non-free" &&
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59 &&
sudo apt-get update -qq 
sudo apt-get install spotify-client -y

# sublime
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update -qq
sudo apt-get install sublime-text-installer -y

# google chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update -qq
sudo apt-get install google-chrome-stable -y

# finalterm
sudo add-apt-repository ppa:fuzzgun/finalterm # ppa for Ubuntu 14.04
sudo apt-get update -qq
sudo apt-get install finalterm -y

# gimp
sudo apt-get install gimp
