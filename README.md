# `icrc2-wallet`

A basic wallet implementation to interact with icrc tokens on local icrc-ledger
  - setups local icrc-ledger
  - mint icrc-test tokens
  - transfer and get_balance functions


Setup

Install the IC_SDK:
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"

Install the lastest ICRC-1 Ledger files
curl -o download_latest_icrc1_ledger.sh "https://raw.githubusercontent.com/dfinity/ic/1f1d8dd8c294d19a5551a022e3f00f25da7dc944/rs/rosetta-api/scripts/download_latest_icrc1_ledger.sh"
chmod +x download_latest_icrc1_ledger.sh
./download_latest_icrc1_ledger.sh

If you want to start working on your project right away, you might want to try the following commands:

## Running the project locally

If you want to use the project locally: 
Run the 'setup_ledger_and_deploy.sh' file

chmod +x <path/to/script>
./<path/to/script>

Once the job completes, application will be available at `http://localhost:4943?canisterId={asset_canister_id}`.
