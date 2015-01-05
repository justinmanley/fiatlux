#!/bin/bash

source setup/config.sh

# use gvm (go version manager to install go)
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)

source ~/.profile

gvm install go${VERSION["GOLANG"]}
gvm use go1 --default