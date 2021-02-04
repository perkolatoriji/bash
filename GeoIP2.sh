#!/bin/bash
LATLON=$(curl -s https://freegeoip.app/xml/ | awk -F'<|>' '/Latitude|Longitude/ {print $3}')

LAT=$(cut -f1 -d" " <<< $LATLON)
LON=$(cut -f2 -d" " <<< $LATLON)

echo
echo "Latitude: " $LAT
echo "Longitude:" $LON
echo

curl --request GET \
--url https://freegeoip.app/json/ \
--header 'accept: application/json' \
--header 'content-type: application/json'

#End script
