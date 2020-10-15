#!/bin/bash

echo ""
echo "*** Setting Saagie's custom Base Path to [$ES_PATH}"
echo "*** Setting Saagie's custom Base Path to [$ES2_PATH}"
echo ""
echo " ##### BEFORE"
cat /etc/nginx/nginx.conf

sed -i 's:REPLACE_ES_PATH:'"$ES_PATH"':g' /etc/nginx/nginx.conf
sed -i 's:REPLACE_ES2_PATH:'"$ES2_PATH"':g' /etc/nginx/nginx.conf

echo ""
echo " ##### AFTER"
cat /etc/nginx/nginx.conf

echo ""
echo " ##### LAUNCH ES"
nginx && /usr/local/bin/docker-entrypoint.sh