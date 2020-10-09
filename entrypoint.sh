#!/bin/bash

cd /github/workspace
curl $1 > ip-ranges.json
cat ip-ranges.json | jq -r '.prefixes[] | select(.service=="CLOUDFRONT") | .ip_prefix' > ip-ranges.txt
rm ip-ranges.json
export IPS=$(readarray -t ARRAY < ip-ranges.txt; IFS=','; echo "${ARRAY[*]}")
yq -y ".spec.values.operators.extraProxyCIDR=\"$IPS\"" < releases/base-cluster.yaml > releases/updated-base-cluster.yaml
mv -f releases/updated-base-cluster.yaml releases/base-cluster.yaml
rm ip-ranges.txt