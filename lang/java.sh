#!/bin/bash

source setup/config.sh

# https://www.digitalocean.com/community/tutorials/how-to-install-java-on-ubuntu-with-apt-get

sudo apt-get install python-software-properties -y
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -qq

# install java 8
sudo apt-get install ${VERSION["JAVA"]}-installer -y

