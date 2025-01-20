# `icrc2-wallet`

A basic wallet implementation to interact with ICRC tokens on a local ICRC ledger. This project:

- Sets up a local ICRC ledger.
- Mints ICRC test tokens.
- Provides `transfer` and `get_balance` functions.

## Setup

### Install the IC SDK

```bash
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
```

### Install the Latest ICRC-1 Ledger Files

```bash
curl -o download_latest_icrc1_ledger.sh "https://raw.githubusercontent.com/dfinity/ic/1f1d8dd8c294d19a5551a022e3f00f25da7dc944/rs/rosetta-api/scripts/download_latest_icrc1_ledger.sh"
chmod +x download_latest_icrc1_ledger.sh
./download_latest_icrc1_ledger.sh
```

### Getting Started

If you want to start working on your project right away, follow these commands:

## Running the Project Locally

To use the project locally, run the `setup_ledger_and_deploy.sh` file:

```bash
chmod +x <path/to/script>
./<path/to/script>
```

Once the job completes, the application will be available at:

```
http://localhost:4943?canisterId={asset_canister_id}
```

