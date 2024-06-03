#!/bin/bash

apiKey=<insertkeyhere>

# User input loop

read -rp "Enter IP addresses or hashes separated by a space:"$'\n' -a arr
for Input in "${arr[@]}"; do

number=$((number+1))

# Checks for IP addresses

if [[ $Input =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then

# IP geolocation query

echo $'\n'
echo "#$number"
echo -e "\e[36m------------------------"
echo "$Input Location:"
echo -e "------------------------\e[0m"

curl -s https://ipinfo.io/$Input | grep -o '"city":.*"\|"region":.*"\|"country":.*"\|"org":.*"\|"hostname":.*"' | tr -d \"

# IP VirusTotal detections count

echo -e "\n\e[36m-------------------------------------"
echo "$Input VirusTotal Detections:"
echo -e "-------------------------------------\e[0m"

curl -s --request GET --url "https://www.virustotal.com/api/v3/ip_addresses/$Input" --header "x-apikey:$apiKey" | grep -Eo '"result">

else

# If not an IP, runs through VirusTotal hash analysis

echo $'\n'
echo "#$number"
echo -e "\e[36m---------------------------"
echo "Hash Virustotal Detections:"
echo -e "---------------------------\e[0m"

echo -e "Hash: $Input\n"

curl -s --request GET --url "https://www.virustotal.com/api/v3/files/$Input" --header "x-apikey:$apiKey" | grep -Eo '"category": "ma>

fi
done
