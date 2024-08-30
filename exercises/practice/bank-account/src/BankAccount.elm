module BankAccount exposing (Error(..), balance, close, deposit, open, withdraw)


type BankAccount
    = TODO


type Error
    = AccountNotOpen
    | AccountAlreadyOpen
    | WithdrawAmountMoreThanBalance
    | WithdrawAmountNegative
    | DepositAmountNegative


open : Maybe BankAccount -> Result Error BankAccount
open maybeAccount =
    Debug.todo "Please implement open"


close : BankAccount -> BankAccount
close account =
    Debug.todo "Please implement close"


balance : BankAccount -> Result Error Int
balance account =
    Debug.todo "Please implement balance"


deposit : Int -> BankAccount -> Result Error BankAccount
deposit amount account =
    Debug.todo "Please implement deposit"


withdraw : Int -> BankAccount -> Result Error BankAccount
withdraw amount account =
    Debug.todo "Please implement withdraw"
