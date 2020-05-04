#!/bin/bash

# Configure AWS CLI profile
aws configure set default.aws_access_key_id $1
aws configure set default.aws_secret_access_key $2
aws configure set default.region $3
aws configure set default.output json
aws configure list