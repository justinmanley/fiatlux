#!/bin/bash

source setup/config.sh

# ruby dependencies
sudo apt-get update -qq
sudo apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties

# rvm
sudo apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
rvm install ${VERSION["RVM"]}
rvm use ${VERSION["RVM"]} --default
ruby -v

# rails
gem install rails
rails -v
