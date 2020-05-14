#!/bin/bash
set -euo pipefail

################################################################################
## This script expects the following parameters:
## $1: your AWS access key id
## $2: your AWS access token
## $3: an AWS region
################################################################################

[[ $# -eq 3 && $1 != "NO_AWS" ]] \
  && echo "Configuring AWS CLI profile" \
  && aws configure set default.aws_access_key_id $1 \
  && aws configure set default.aws_secret_access_key $2 \
  && aws configure set default.region $3 \
  && aws configure set default.output json