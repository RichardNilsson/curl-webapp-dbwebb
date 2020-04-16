#!/usr/bin/env bash
# -*- coding: utf-8 -*-

api_key=$(pass services/education/bth/dbwebb.se/webapp/lager/api-key)
base_url='https://lager.emilfolino.se/v2'
sub_url='deliveries'


# Declare an array called "ids"
declare -a ids
# Fill the array with the order ids available
readarray -t ids < <(curl --silent -X GET "$base_url/$sub_url?api_key=$api_key" | jq ".data[].id")

for id in ${ids[*]}
do
    printf "Removing delivery with id: %s\\n" "$id"
    curl -d "id=$id&api_key=$api_key" -X DELETE "$base_url/$sub_url"
done
