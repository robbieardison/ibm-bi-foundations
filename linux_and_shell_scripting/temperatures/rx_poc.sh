#! /bin/bash

today=$(date +%Y%m%d)
weather_report=raw_data_$today

city=Casablanca
curl wttr.in/$city?format="%t\n%T\n" --output $weather_report

grep °C $weather_report > temperatures.txt

obs_temp=$(head -1 $weather_report)

echo "Current Temperature: $obs_temp"
