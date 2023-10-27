#!/bin/bash
set -e
METADATA_PATH=/opt/elasticbeanstalk/deployment/cfn-metadata-cache.json
VERSION_MANIFEST_PATH=/opt/elasticbeanstalk/deployment/app_version_manifest.json

export ENVIRONMENT_ID=$(cat $METADATA_PATH | jq -r '.EbResource."AWS::ElasticBeanstalk::Metadata".EnvironmentId')
export ENVIRONMENT_NAME=$(cat $METADATA_PATH | jq -r '.EbResource."AWS::ElasticBeanstalk::Metadata".EnvironmentName')
export VERSION_LABEL=$(cat $VERSION_MANIFEST_PATH | jq -r '.VersionLabel')

mkdir -p public
envsubst < index.template.html > public/index.html