#!/bin/bash

sudo apt-get install ghc -y
sudo apt-get install cabal-install -y

cabal update
cabal install random