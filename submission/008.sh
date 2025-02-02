#!/bin/bash

tx="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

raw_tx=$(./bitcoin-cli getrawtransaction "$tx" true)

witness=$(echo "$raw_tx" | jq -r '.vin[0].txinwitness[2]')

if [ -z "$witness" ]; then
  echo "don't"
  exit 1
fi

key1=$(echo "$witness" | cut -c 5-70)
key2=$(echo "$witness" | cut -c 85-150)

echo "$key1"
echo "$key2"
