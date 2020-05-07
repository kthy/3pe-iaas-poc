#!/bin/bash

echo "--------------------------------------------------------------------------------"
echo "Provisioning done!"

echo ""
aws configure list

echo ""
for pkg in nginx redis-server; do
  echo "Installed ${pkg} $(apt-cache policy $pkg | grep Installed | sed -r 's/.*: (.+)/\1/')"
done

echo ""
echo "nginx running on http://$(hostname -I | sed -r 's/\s*$//')/"