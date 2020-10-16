#!/bin/bash

echo ""
echo "*** Setting Saagie's custom Base Path to [$ES_PATH}"
sed -i 's:REPLACE_ES_PATH:'"$ES_PATH"':g' /etc/nginx/nginx.conf

echo ""
echo "*** Setting Saagie's custom Base Path to [$ES2_PATH}"
sed -i 's:REPLACE_ES2_PATH:'"$ES2_PATH"':g' /etc/nginx/nginx.conf

echo ""
echo " ##### LAUNCH nginx && elasticsearch"
# one line to exit if nginx exits before launching ES
nginx && su - elasticsearch -c /usr/local/bin/docker-entrypoint.sh