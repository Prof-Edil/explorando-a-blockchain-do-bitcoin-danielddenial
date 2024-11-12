#!/bin/bash

hash_123321=$(bitcoin-cli getblockhash 123321)

for txid in $(bitcoin-cli getblock $hash_123321 | jq -r '.tx[]'); do
    bitcoin-cli getrawtransaction $txid true | jq -c '.vout[]' | while read output; do
        vout_index=$("$output" | jq -r '.n')
        spent=$(bitcoin-cli gettxout $txid $vout_index)

        if [ -n "$spent" ]; then
            address=$("$output" | jq -r '.scriptPubKey.addresses[0]')
            echo "$address"
            break 2
        fi
    done
done




