#!/usr/bin/env bash
# -*- coding: utf-8 -*-
URL='https://lager.emilfolino.se/v2/products'
API_KEY=$(pass services/education/bth/dbwebb.se/webapp/lager/api-key)
# Adding products
curl --silent \
-d "name=Playstation Classic" \
-d "api_key=$API_KEY" \
-d "article_number=11887" \
-d "description=Res tillbaka i tiden till Japan, 1994 när en legend föddes och spela klassiska spel med PlayStation Classic. Tillskillnad från originalversionen är denna konsol 45% mindre men kommer med samma knapplayout, logotyp och förpackning som originalet samt det kommer med de 20 bästa spelen förinstallerade som t.ex. Final Fantasy VII, Tekken 3 och Wild Arms. Tack var ett inbyggt minneskort kan du spara dina framsteg när du testar dina framsteg i alla spel." \
-d "specifiers={
    \"storlek\":\"45% mindre än originalet\",
    \"kontroller\":\"2 trådbundna kontroller\",
    \"spel\":\"20 förinstallerade spel\"
    }" \
-d "stock=10" \
-d "location=A100" \
-d "price=399" \
-X POST "$URL" > /dev/null

curl --silent \
-d "name=200GB SanDisk Ultra microSDXC Class 10 UHS-I 100MB/s A1" \
-d "api_key=$API_KEY" \
-d "article_number=61063" \
-d "description=För full HD video, bättre bilder, snabbare appar." \
-d "specifiers={
    \"användningsOmråden\":\"Särskilt rekommenderat till smartphones och tablets. Även lämplig för terminalutrustning med SDHC-kortplats.\",
    \"stöd\":\"Video stöd C10, U1, Full HD\",
    \"optimerad\":\"Optimerat för appar A1\",
    \"tillbehör\":\"SD-Adapter ingår.\"
    }" \
-d "stock=15" \
-d "location=A101" \
-d "price=349" \
-X POST "$URL" > /dev/null

curl --silent \
-d "name=256GB Samsung Evo%2b microSDXC Class 10 UHS-I" \
-d "api_key=$API_KEY" \
-d "article_number=57666" \
-d "description=EVO Plus minneskort erbjuder mer utrymme och högre hastighet. Ge dina enheter maximerat lagringsutrymme med klassens snabbaste läs-/skrivhastigheter – idealiskt för 4K UHD-video.* EVO Plus erbjuder imponerande prestanda och tillförlitlighet, för trygg lagring av foton och videor." \
-d "specifiers={
    \"hastighet\":\"Fort ska det gå\",
    \"kapacitet\":\"Kapacitet som tillfredsställer\",
    \"kompabilitet\":\"Bredare kompatibilitet\"
    }" \
-d "stock=20" \
-d "location=A102" \
-d "price=499" \
-X POST "$URL" > /dev/null

# curl \
# -d "name=<name>" \
# -d "api_key=$API_KEY" \
# -d "article_number=<article_number>" \
# -d "description=<description>" \
# -d "specifiers={'<key>':'<value>'}" \
# -d "stock=<stock>" \
# -d "location=<location>" \
# -d "price=<price>" \
# -X POST "$URL"

# Getting products
curl --silent -X GET "$URL?api_key=$API_KEY" | jq ".data[].name" | xargs echo 'Added products:'
