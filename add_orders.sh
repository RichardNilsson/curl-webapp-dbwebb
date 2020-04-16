#!/usr/bin/env bash
# -*- coding: utf-8 -*-
URL='https://lager.emilfolino.se/v2/orders'
API_KEY=$(pass services/education/bth/dbwebb.se/webapp/lager/api-key)
# Adding products
curl --silent \
-d "name=Ada Lovelace" \
-d "api_key=$API_KEY" \
-d "address=Stockholmsvägen 15" \
-d "zip=12345" \
-d "city=Stockholm" \
-d "country=Sweden" \
-d "status_id=100" \
-X POST "$URL" > /dev/null

curl --silent \
-d "name=Bob Fabry" \
-d "api_key=$API_KEY" \
-d "address=Göteborgsvägen 12" \
-d "zip=41280" \
-d "city=Göteborg" \
-d "country=Sweden" \
-d "status_id=100" \
-X POST "$URL" > /dev/null

curl --silent \
-d "name=Charlie Murphy" \
-d "api_key=$API_KEY" \
-d "address=Malmövägen 13" \
-d "zip=21345" \
-d "city=Malmö" \
-d "country=Sweden" \
-d "status_id=100" \
-X POST "$URL" > /dev/null


# Getting orders
curl --silent -X GET "$URL?api_key=$API_KEY" | jq ".data[].name" | xargs echo 'Added orders for:'
