#!/bin/bash
set -e

if [ ! $IS_DEVELOPMENT ]
then
  cfn=/opt/elasticbeanstalk/deployment/cfn-metadata-cache.json
  version=/opt/elasticbeanstalk/deployment/app_version_manifest.json
  
  export ENVIRONMENT_ID=$(cat $cfn | jq -r '.EbResource."AWS::ElasticBeanstalk::Metadata".EnvironmentId')
  export ENVIRONMENT_NAME=$(cat $cfn | jq -r '.EbResource."AWS::ElasticBeanstalk::Metadata".EnvironmentName')
  export VERSION_LABEL=$(cat $version | jq -r '.VersionLabel')
else
  export ENVIRONMENT_ID="dev-env-id"
  export ENVIRONMENT_NAME="dev-env-blue"
  export VERSION_LABEL="dev-version"
fi

if [[ $ENVIRONMENT_NAME == *blue* ]]; then
    export BG_COLOR="blue"
elif [[ $ENVIRONMENT_NAME == *green* ]]; then
    export BG_COLOR="green"
else
    export BG_COLOR=""
fi


mkdir -p public
envsubst < index.template.html > public/index.html