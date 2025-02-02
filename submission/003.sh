#!/bin/bash
hash=$(bitcoin-cli getblockhash 123456)
bitcoin-cli getblock $hash 2 | jq '[.tx[].vout] | flatten | length'
