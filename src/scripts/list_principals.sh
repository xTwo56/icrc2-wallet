#!/bin/bash

# Get the list of identities
identity_list=$(dfx identity list)

# Check if the list is empty
if [ -z "$identity_list" ]; then
	echo "No identities found."
	exit 0
fi

echo "Principals of all identities in the dfx environment:"
echo "---------------------------------------------------"

# Iterate through each identity and print its principal
while read -r identity_name; do
	if [ -n "$identity_name" ]; then
		principal=$(dfx identity get-principal --identity "$identity_name" 2>/dev/null)
		if [ $? -eq 0 ]; then
			echo "Identity: $identity_name | Principal: $principal"
		else
			echo "Error: Unable to retrieve principal for identity '$identity_name'."
		fi
	fi
done <<<"$identity_list"

echo "Wallet Canister: $(dfx canister id icrc2-wallet-backend)"

exit 0
