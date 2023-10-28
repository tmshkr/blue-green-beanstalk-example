#!/bin/bash
set -e

env_id=$(cat ENV_ID)
prod_cname=$(cat PROD_CNAME) 2>/dev/null # need to know ahead of time if swapping cnames
env=$(aws elasticbeanstalk describe-environments --environment-ids $env_id)
server_names=()

if [ $prod_cname ]; then
  server_names+=($prod_cname)
else
  cname=$(echo $env | jq -r '.Environments[0].CNAME')
  server_names+=($cname)
fi

endpoint_url=$(echo $env | jq -r '.Environments[0].EndpointURL')

if [ ! is_ip_address $endpoint_url; ] then
  server_names+=($endpoint_url)
fi


for domain in "${server_names[@]}"; do
    export SERVER_NAME=$domain
    envsubst < default.conf.template > nginx/$domain.conf
done

is_ip_address() {
  local ip="$1"
  if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    IFS='.' read -ra octets <<< "$ip"
    for octet in "${octets[@]}"; do
      if ! [[ "$octet" -ge 0 && "$octet" -le 255 ]]; then
        return 1
      fi
    done
    return 0
  else
    return 1
  fi
}
