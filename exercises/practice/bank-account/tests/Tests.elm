module Tests exposing (tests)

import BankAccount exposing (Error(..))
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "BankAccount"
        [ -- skip <|
          test "Newly opened account has zero balance" <|
            \() ->
                BankAccount.open Nothing
                    |> Result.andThen BankAccount.balance
                    |> Expect.equal (Ok 0)
        , skip <|
            test "Single deposit" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 100)
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Ok 100)
        , skip <|
            test "Multiple deposits" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 100)
                        |> Result.andThen (BankAccount.deposit 50)
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Ok 150)
        , skip <|
            test "Withdraw once" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 100)
                        |> Result.andThen (BankAccount.withdraw 75)
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Ok 25)
        , skip <|
            test "Withdraw twice" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 100)
                        |> Result.andThen (BankAccount.withdraw 80)
                        |> Result.andThen (BankAccount.withdraw 20)
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Ok 0)
        , skip <|
            test "Can do multiple operations sequentially" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 100)
                        |> Result.andThen (BankAccount.deposit 110)
                        |> Result.andThen (BankAccount.withdraw 200)
                        |> Result.andThen (BankAccount.deposit 60)
                        |> Result.andThen (BankAccount.withdraw 50)
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Ok 20)
        , skip <|
            test "Cannot check balance of closed account" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.map BankAccount.close
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Err AccountNotOpen)
        , skip <|
            test "Cannot deposit into closed account" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.map BankAccount.close
                        |> Result.andThen (BankAccount.deposit 50)
                        |> Expect.equal (Err AccountNotOpen)
        , skip <|
            test "Cannot withdraw from closed account" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.map BankAccount.close
                        |> Result.andThen (BankAccount.withdraw 50)
                        |> Expect.equal (Err AccountNotOpen)
        , skip <|
            test "Cannot open an already opened account" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.toMaybe
                        |> BankAccount.open
                        |> Expect.equal (Err AccountAlreadyOpen)
        , skip <|
            test "Reopened account does not retain balance" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 50)
                        |> Result.map BankAccount.close
                        |> Result.toMaybe
                        |> BankAccount.open
                        |> Result.andThen BankAccount.balance
                        |> Expect.equal (Ok 0)
        , skip <|
            test "Cannot withdraw more than deposited" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 25)
                        |> Result.andThen (BankAccount.withdraw 50)
                        |> Expect.equal (Err WithdrawAmountMoreThanBalance)
        , skip <|
            test "Cannot withdraw negative" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit 100)
                        |> Result.andThen (BankAccount.withdraw -50)
                        |> Expect.equal (Err WithdrawAmountNegative)
        , skip <|
            test "Cannot deposit negative" <|
                \() ->
                    BankAccount.open Nothing
                        |> Result.andThen (BankAccount.deposit -50)
                        |> Expect.equal (Err DepositAmountNegative)
        ]
