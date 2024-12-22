#!/bin/bash -e

export ENVIRONMENT_ID=$(cat /opt/elasticbeanstalk/config/ebenvinfo/envid)
env=$(aws elasticbeanstalk describe-environments --environment-ids $ENVIRONMENT_ID)
export ENVIRONMENT_NAME=$(echo $env | jq -r '.Environments[0].EnvironmentName')
export VERSION_LABEL=$(echo $env | jq -r '.Environments[0].VersionLabel')

if [[ $ENVIRONMENT_NAME == *blue* ]]; then
  export BG_COLOR="blue"
elif [[ $ENVIRONMENT_NAME == *green* ]]; then
  export BG_COLOR="green"
else
  export BG_COLOR=""
fi

mkdir -p public
envsubst <index.template.html >public/index.html
