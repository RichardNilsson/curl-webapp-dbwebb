#!/usr/bin/env bash
# -*- coding: utf-8 -*-
base_url='https://lager.emilfolino.se/v2/'
sub_url='order_items'
api_key=$(pass services/education/bth/dbwebb.se/webapp/lager/api-key)
# Declare an array called "ids"
declare -a product_ids
# Fill the array with the product ids available
readarray -t product_ids < <(curl --silent -X GET "$base_url/products?api_key=$api_key" | jq ".data[].id")

# Declare an array called "ids"
declare -a order_ids
# Fill the array with the product ids available
readarray -t order_ids < <(curl --silent -X GET "$base_url/orders?api_key=$api_key" | jq ".data[].id")

for order_id in ${order_ids[*]}
do
    for product_id in ${product_ids[*]}
    do
        printf "Adding product with id: %s to order with id: %s\\n" "$product_id" "$order_id"
        curl --silent \
        -d "order_id=$order_id" \
        -d "product_id=$product_id" \
        -d "amount=$((1 + RANDOM % 35))" \
        -d "api_key=$api_key" \
        -X POST "$base_url/$sub_url" > /dev/null
    done
done


# Getting orders
# curl --silent -X GET "$base_url/orders?api_key=$api_key" | jq "."
