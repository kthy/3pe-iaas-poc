#!/bin/bash
set -euo pipefail

echo ""
echo "--------------------------------------------------------------------------------"
echo "Provisioning done!"
echo "--------------------------------------------------------------------------------"

echo ""
echo "Installed $(aws --version | sed -r 's/^([^[:blank:]]+).*/\1/')"
for PKG in nginx redis; do
  VERSION="$(apk version ${PKG} | grep ${PKG} | sed -r 's/^[^\-]+-([^[:blank:]]+).*/\1/')"
  echo "Installed ${PKG}/$VERSION"
done

echo ""
echo "AWS CLI configuration:"
echo "---------------------------------------------------------------------"
aws configure list
echo "---------------------------------------------------------------------"