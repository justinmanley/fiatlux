#!/bin/sh

# install gdal (contains ogr2ogr utility, among others)
# sudo apt-get install gdal-bin -y

# install qgis
# sudo apt-get install qgis -y

# install josm
echo "deb http://josm.openstreetmap.de/apt utopic universe" >> sudo /etc/apt/sources.list
wget -q https://josm.openstreetmap.de/josm-apt.key -O- | sudo apt-key add - # get the public key
sudo apt-get update -qq
sudo apt-get remove -y josm josm-plugins && sudo apt-get -y install josm