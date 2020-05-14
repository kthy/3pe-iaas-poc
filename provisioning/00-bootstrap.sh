#!/bin/bash

# See <https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/>
set -euo pipefail

################################################################################
## This script expects the following parameter:
## $1: canonical timezone name from the tz database
################################################################################

# Update image
apk --quiet update
apk --quiet --no-cache upgrade
apk --quiet --no-cache add tzdata

# Set time zone
[[ $# -eq 1 && -f /usr/share/zoneinfo/$1 ]] \
  && echo "Setting timezone to $1" \
  && ln -fs /usr/share/zoneinfo/$1 /etc/localtime