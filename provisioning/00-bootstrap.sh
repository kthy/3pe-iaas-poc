#!/bin/bash

# Install packages
apt-get -q update
apt-get -q -y install nginx=1.14.0-0ubuntu1.7 unzip

# Hook up nginx www dir
if ! [ -L /var/www/html ]; then
  rm -rf /var/www/html
  ln -fs /vagrant/frontend /var/www/html
fi

# Install and configure AWS CLI
if ! [ -x "$(command -v aws)" ]; then
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -q awscliv2.zip
  ./aws/install
  rm -rf ./aws
  rm awscliv2.zip
fi