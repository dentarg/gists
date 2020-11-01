#!/bin/sh

# This script is used in FreeBSD

IP=$(ifconfig <INTERFACE> | grep inet | awk '{ print $2 }')

curl -s -o /dev/null \
     -X PATCH "https://api.cloudflare.com/client/v4/zones/<ZONE ID>/dns_records/<RECORD ID>" \
     -H "X-Auth-Email: <EMAIL>" \
     -H "X-Auth-Key: <KEY>" \
     -H "Content-Type: application/json" \
     --data "{\"content\":\"${IP}\"}"
