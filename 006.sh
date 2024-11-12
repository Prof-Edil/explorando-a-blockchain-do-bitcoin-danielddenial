#!/bin/bash

hash_256128=$(./bitcoin-cli getblockhash 256128)

coinbase_txid=$(./bitcoin-cli getblock $hash_256128 | jq -r '.tx[0]')

hash_257343=$(./bitcoin-cli getblockhash 257343)

./bitcoin-cli getblock $hash_257343 | jq -r '.tx[]' | while read TXID; do
    if ./bitcoin-cli getrawtransaction $TXID true | jq -e ".vin[] | select(.txid == \"$coinbase_txid\")" > /dev/null; then
        echo "$TXID"
        break
    fi
done
