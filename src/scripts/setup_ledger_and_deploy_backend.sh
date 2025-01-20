#!/bin/bash

set -e
# Check if dfx is running
echo "Checking if dfx is already running..."
if pgrep -x "dfx" >/dev/null; then
	echo "dfx is running. Stopping the existing instance..."
	dfx stop
else
	echo "No existing dfx instance found."
fi

dfx start --clean --background
echo "dfx started successfully."

# Get the MINTER principal
echo "Getting MINTER principal..."
MINTER=$(dfx --identity anonymous identity get-principal)
if [ -z "$MINTER" ]; then
	echo "Failed to get MINTER principal."
	exit 1
fi
echo "MINTER principal: $MINTER"

# Step 3: Get the DEFAULT principal
echo "Getting DEFAULT principal..."
DEFAULT=$(dfx identity get-principal)
if [ -z "$DEFAULT" ]; then
	echo "Failed to get DEFAULT principal."
	exit 1
fi
echo "DEFAULT principal: $DEFAULT"

# Deploying icrc1_ledger_canister
echo "Deploying icrc1_ledger_canister..."
dfx deploy icrc1_ledger_canister --argument "(variant { Init =
record {
     token_symbol = \"IT\";
     token_name = \"icrc-test\";
     minting_account = record { owner = principal \"${MINTER}\" };
     transfer_fee = 10_000;
     metadata = vec {};
     initial_balances = vec { record { record { owner = principal \"${DEFAULT}\"; }; 10_000_000_000; }; };
     archive_options = record {
         num_blocks_to_archive = 1000;
         trigger_threshold = 2000;
         controller_id = principal \"${MINTER}\";
     };
 }
})"
echo "icrc1_ledger_canister deployed successfully."

# Deploy the icrc2-wallet-backend
echo "Deploying icrc2-wallet-backend..."
dfx deploy icrc2-wallet-backend
echo "icrc2-wallet-backend deployed successfully."

# Transfer tokens
echo "Getting icrc2-wallet-backend canister ID..."
WALLET_CANISTER_ID=$(dfx canister id icrc2-wallet-backend)
if [ -z "$WALLET_CANISTER_ID" ]; then
	echo "Failed to get icrc2-wallet-backend canister ID."
	exit 1
fi
echo "icrc2-wallet-backend canister ID: $WALLET_CANISTER_ID"

echo "Transferring tokens to icrc2-wallet-backend..."
dfx canister call icrc1_ledger_canister icrc1_transfer "(record {
  to = record {
    owner = principal \"${WALLET_CANISTER_ID}\";
  };
  amount = 1_000_000_000;
})"
echo "Tokens transferred successfully."

echo "All steps completed successfully."
