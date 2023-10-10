#!/bin/bash

# Get environment from github.ref_name
ENVIRONMENT=$(cat ENVIRONMENT)

# Retrieve parameters from AWS SSM
aws ssm get-parameters-by-path --path "/test-app/$ENVIRONMENT/" --recursive --with-decryption --query "Parameters[*].[Name,Value]" --output text | while read -r name value; do
  # Add parameter key-value pair to the .env file
  echo "$(echo $name | sed "s/\/test-app\/$ENVIRONMENT\///")=\"$value\"" >> .env
done
