#!/bin/bash

hash_123321=$(./bitcoin-cli getblockhash 123321)

./bitcoin-cli getblock $hash_123321 | jq -r '.tx[]' | while read TXID; do
    if ./bitcoin-cli getrawtransaction $TXID true | jq -e ".vin[]" > /dev/null; then
        echo "$TXID"
        break
    fi
done




