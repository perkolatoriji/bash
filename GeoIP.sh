#!/bin/bash
LATLON=$(wget -o /dev/null -O - https://freegeoip.app/xml/ | awk -F'<|>' '/Latitude|Longitude/ {print $3}')

LAT=$(cut -f1 -d" " <<< $LATLON)
LON=$(cut -f2 -d" " <<< $LATLON)

echo "Latitude: " $LAT
echo "Longitude:" $LON
#End sript

