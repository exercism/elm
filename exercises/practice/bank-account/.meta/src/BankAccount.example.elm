module BankAccount exposing (Error(..), balance, close, deposit, open, withdraw)


type BankAccount
    = BankAccount { accountBalance : Int, opened : Bool }


type Error
    = AccountNotOpen
    | AccountAlreadyOpen
    | WithdrawAmountMoreThanBalance
    | WithdrawAmountNegative
    | DepositAmountNegative


open : Maybe BankAccount -> Result Error BankAccount
open maybeAccount =
    case maybeAccount of
        Nothing ->
            Ok (BankAccount { accountBalance = 0, opened = True })

        Just (BankAccount { accountBalance, opened }) ->
            if opened then
                Err AccountAlreadyOpen

            else
                open Nothing


close : BankAccount -> BankAccount
close (BankAccount account) =
    BankAccount { account | opened = False }


balance : BankAccount -> Result Error Int
balance (BankAccount { accountBalance, opened }) =
    if opened then
        Ok accountBalance

    else
        Err AccountNotOpen


deposit : Int -> BankAccount -> Result Error BankAccount
deposit amount (BankAccount ({ accountBalance, opened } as account)) =
    case ( opened, amount >= 0 ) of
        ( False, _ ) ->
            Err AccountNotOpen

        ( _, False ) ->
            Err DepositAmountNegative

        ( True, True ) ->
            Ok (BankAccount { account | accountBalance = accountBalance + amount })


withdraw : Int -> BankAccount -> Result Error BankAccount
withdraw amount (BankAccount ({ accountBalance, opened } as account)) =
    case ( opened, amount >= 0, amount <= accountBalance ) of
        ( False, _, _ ) ->
            Err AccountNotOpen

        ( _, False, _ ) ->
            Err WithdrawAmountNegative

        ( _, _, False ) ->
            Err WithdrawAmountMoreThanBalance

        ( True, True, True ) ->
            Ok (BankAccount { account | accountBalance = accountBalance - amount })
