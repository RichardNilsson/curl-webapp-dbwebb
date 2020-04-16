#!/usr/bin/env bash
# -*- coding: utf-8 -*-
api_key=$(pass services/education/bth/dbwebb.se/webapp/lager/api-key)
base_url='https://lager.emilfolino.se/v2'
sub_url='products'
sub_url2='deliveries'


# Declare an array called "product_ids"
declare -a product_ids
# Fill the array with the product product_ids available
readarray -t product_ids < <(curl --silent -X GET "$base_url/$sub_url?api_key=$api_key" | jq ".data[].id")

# Declare an array called "product_stocks"
declare -a product_stocks
# Fill the array with the product product_ids available
readarray -t product_stocks < <(curl --silent -X GET "$base_url/$sub_url?api_key=$api_key" | jq ".data[].stock")

for index in "${!product_ids[@]}" #${product_ids[*]}
do
    amount="$((2 + RANDOM % 22))"

    printf "Making delivery of %s products with product id: %s\\n" "$amount" "${product_ids[$index]}"
    printf "The previous stock of %s was: %s\\n" "${product_ids[$index]}" "${product_stocks[index]}"
    printf "The new stock is %s\\n" "$((product_stocks[index] + amount))"

    curl --silent \
    -d "product_id=${product_ids[$index]}" \
    -d "api_key=$api_key" \
    -d "amount=$amount" \
    -d "delivery_date=$(date +'%Y-%m-%d')" \
    -d "comment=I have delivered $amount products with the product id: ${product_ids[$index]}." \
    -X POST "$base_url/$sub_url2" > /dev/null

    curl --silent \
    -d "id=${product_ids[$index]}" \
    -d "api_key=$api_key" \
    -d "amount=$amount" \
    -d "stock=$((product_stocks[index] + amount))" \
    -X PUT "$base_url/$sub_url" > /dev/null
done

# Getting deliveries
# curl --silent -X GET "$base_url/$sub_url2?api_key=$api_key" | jq "."
