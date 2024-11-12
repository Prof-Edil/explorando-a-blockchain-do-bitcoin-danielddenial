#!/bin/bash
chavePub1=$(./bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 true | jq -r '.vin[0].txinwitness[1]')
chavePub2=$(./bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 true | jq -r '.vin[1].txinwitness[1]')
chavePub3=$(./bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 true | jq -r '.vin[2].txinwitness[1]')
chavePub4=$(./bitcoin-cli getrawtransaction 37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517 true | jq -r '.vin[3].txinwitness[1]')

echo $(./bitcoin-cli createmultisig 1 "[\"$chavePub1\", \"$chavePub2\", \"$chavePub3\", \"$chavePub4\"]" | jq -r ".address")
