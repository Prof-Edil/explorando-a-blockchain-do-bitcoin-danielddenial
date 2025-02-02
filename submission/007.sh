#!/bin/bash

Hash=$(bitcoin-cli getblockhash 123321)
Block=$(bitcoin-cli getblock $Hash | jq -r '.tx[]')

for txid in $Block; do

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
