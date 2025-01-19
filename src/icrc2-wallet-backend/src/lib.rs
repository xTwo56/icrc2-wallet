use candid::{CandidType, Deserialize, Principal};
use icrc_ledger_types::icrc1::account::Account;
use icrc_ledger_types::icrc1::transfer::{BlockIndex, NumTokens, TransferArg, TransferError};
use serde::Serialize;

#[derive(CandidType, Deserialize, Serialize)]
pub struct TransferInputArg {
    amount: NumTokens,
    to_account: Account,
}

#[derive(CandidType, Deserialize, Serialize)]
pub struct BalanceInputArg {
    canister: Principal,
    owner: Account,
}

#[ic_cdk::update]
async fn transfer(args: TransferInputArg) -> Result<BlockIndex, String> {
    ic_cdk::println!(
        "Transferring {} tokens to account {}",
        &args.amount,
        &args.to_account,
    );

    let transfer_args: TransferArg = TransferArg {
        memo: None,
        amount: args.amount,
        from_subaccount: None,
        fee: None,
        to: args.to_account,
        created_at_time: None,
    };

    ic_cdk::call::<(TransferArg,), (Result<BlockIndex, TransferError>,)>(
        Principal::from_text("").expect("Could not decode the principal."),
        "icrc1_transfer",
        (transfer_args,),
    )
    .await
    .map_err(|e| format!("ledger not found: {:?}", e))?
    .0
    .map_err(|e| format!("ledger transfer failed:  {:?}", e))
}

#[ic_cdk::query]
async fn get_balance(args: BalanceInputArg) -> Result<u128, String> {
    let account = args.owner;
    let result: Result<(u128,), _> =
        ic_cdk::call(args.canister, "icrc1_balance_of", (account,)).await;

    match result {
        Ok((balance,)) => Ok(balance),
        Err(e) => Err(format!("Error fetching balance: {:?}", e)),
    }
}
