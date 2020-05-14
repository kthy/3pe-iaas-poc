#!/bin/bash
set -euo pipefail

################################################################################
## This script expects the following parameter:
## $1: path of provisioning directory
################################################################################

# Install and configure AWS CLI
# cf. <https://github.com/aws/aws-cli/issues/3553#issuecomment-615149941>
# and <https://github.com/sgerrand/alpine-pkg-glibc/issues/119#issuecomment-626627458>
if ! [ -x "$(command -v aws)" ]; then
  GLIBC_VER=2.31-r0
  AWSCLIZIP=awscli-exe-linux-x86_64.zip
  echo "Installing AWS CLI ..." \
    && curl -sL https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -o /etc/apk/keys/sgerrand.rsa.pub \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk \
    && curl -sLO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk \
    && echo "  (ignore error message 'foo is not a symbolic link')" \
    && apk --quiet --no-cache add binutils glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk \
    && ln -fs /usr/glibc-compat/lib/ld-2.31.so /usr/glibc-compat/lib/ld-linux-x86-64.so.2 \
    && curl -sLO https://awscli.amazonaws.com/${AWSCLIZIP} \
    && unzip -q ${AWSCLIZIP} \
    && ./aws/install \
    && rm -rf ./aws \
        /usr/local/aws-cli/v2/*/dist/aws_completer \
        /usr/local/aws-cli/v2/*/dist/awscli/data/ac.index \
        /usr/local/aws-cli/v2/*/dist/awscli/examples \
    && apk --quiet --no-cache del binutils \
    && rm ${AWSCLIZIP} glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk
fi

# Install and configure nginx
if ! [ -x "$(command -v nginx)" ]; then
  echo "Installing nginx ..." \
    && apk --quiet --no-cache add nginx \
    && if ! [ -L /var/www/html ]; then
        ln -fs /vagrant/frontend /var/www/html
       fi \
    && cp -f $1/cfg/nginx.conf.template /etc/nginx/conf.d/default.conf \
    && rc-update add nginx default \
    && rc-service nginx start
fi

# Install and configure redis
if ! [ -x "$(command -v redis-cli)" ]; then
  REDISPWD=`openssl rand 60 | openssl base64 -A`
  echo "Installing redis ..." \
    && apk --quiet --no-cache add redis \
    && echo "requirepass ${REDISPWD}" >> /etc/redis.conf \
    && rc-update add redis default \
    && rc-service redis start
fi