#!/bin/bash

# Update image
apt-get -q update
apt-get -q -y upgrade
apt-get -q -y autoremove

# Install and configure AWS CLI
if ! [ -x "$(command -v aws)" ]; then
  apt-get -q -y install unzip
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -q awscliv2.zip
  ./aws/install
  rm -rf ./aws
  rm awscliv2.zip
fi

# Disable Linux disk optimizer (cf. <https://www.nakivo.com/blog/run-linux-hyper-v/>)
sed -ri 's/^(GRUB_CMDLINE_LINUX_DEFAULT=")quiet"/\1elevator=noop"/g' /etc/default/grub
update-grub