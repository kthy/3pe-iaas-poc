#!/bin/bash

# Install packages
apt-get -q -y install nginx
apt-get -q -y install redis-server

# Hook up nginx www dir
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/frontend /var/www/html
fi