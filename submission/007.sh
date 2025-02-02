#!/bin/bash

hash=$(bitcoin-cli getblockhash 123321)
block=$(bitcoin-cli getblock $hash | jq -r '.tx[]')

for txid in $block; do

  tx=$(bitcoin-cli getrawtransaction $txid true)
  vout_count=$(echo "$tx" | jq '.vout | length')

  for (( i=0; i<$vout_count; i++ )); do
    address=$(bitcoin-cli gettxout $txid $i)

    if [[ ! -z "$address" ]]; then
      echo $address | jq -r '.scriptPubKey.address'
      exit 0
    fi

  done

done
