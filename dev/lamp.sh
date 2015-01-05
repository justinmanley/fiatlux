#!/bin/bash

# apache
sudo apt-get install apache2 -y

# mysql
sudo apt-get install mysql-server -y

# php
sudo apt-get install php5 php5-mcrypt php5-mysql -y

# composer
curl -sS https://getcomposer.org/installer | php