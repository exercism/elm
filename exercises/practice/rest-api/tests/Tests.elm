module Tests exposing (tests)

import Expect
import Json.Decode as Decode
import RestApi
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "RestApi"
        [ describe "user management"
            [ -- skip <|
              test "no users" <|
                \() ->
                    case RestApi.buildDatabase "{\"users\":[]}" of
                        Err error ->
                            Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                        Ok database ->
                            RestApi.get database "/users" Nothing
                                |> Expect.equal "{\"users\":[]}"
            , skip <|
                test "add user" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/add" "{\"user\":\"Adam\"}"
                                    |> Expect.equal "{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{},\"balance\":0}"
            , skip <|
                test "get single user" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{},\"balance\":0},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{},\"balance\":0}]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.get database "/users" (Just "{\"users\":[\"Bob\"]}")
                                    |> Expect.equal "{\"users\":[{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{},\"balance\":0}]}"
            ]
        , describe "iou"
            [ skip <|
                test "both users have 0 balance" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{},\"balance\":0},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{},\"balance\":0}]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/iou" "{\"lender\":\"Adam\",\"borrower\":\"Bob\",\"amount\":3}"
                                    |> Expect.equal "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{\"Bob\":3},\"balance\":3},{\"name\":\"Bob\",\"owes\":{\"Adam\":3},\"owed_by\":{},\"balance\":-3}]}"
            , skip <|
                test "borrower has negative balance" <|
                    \() ->
                        case
                            RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{},\"balance\":0},{\"name\":\"Bob\",\"owes\":{\"Chuck\":3},\"owed_by\":{},\"balance\":-3},{\"name\":\"Chuck\",\"owes\":{},\"owed_by\":{\"Bob\":3},\"balance\":3}]}"
                        of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/iou" "{\"lender\":\"Adam\",\"borrower\":\"Bob\",\"amount\":3}"
                                    |> Expect.equal "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{\"Bob\":3},\"balance\":3},{\"name\":\"Bob\",\"owes\":{\"Adam\":3,\"Chuck\":3},\"owed_by\":{},\"balance\":-6}]}"
            , skip <|
                test "lender has negative balance" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{},\"balance\":0},{\"name\":\"Bob\",\"owes\":{\"Chuck\":3},\"owed_by\":{},\"balance\":-3},{\"name\":\"Chuck\",\"owes\":{},\"owed_by\":{\"Bob\":3},\"balance\":3}]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/iou" "{\"lender\":\"Bob\",\"borrower\":\"Adam\",\"amount\":3}"
                                    |> Expect.equal "{\"users\":[{\"name\":\"Adam\",\"owes\":{\"Bob\":3},\"owed_by\":{},\"balance\":-3},{\"name\":\"Bob\",\"owes\":{\"Chuck\":3},\"owed_by\":{\"Adam\":3},\"balance\":0}]}"
            , skip <|
                test "lender owes borrower" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{\"Bob\":3},\"owed_by\":{},\"balance\":-3},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{\"Adam\":3},\"balance\":3}]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/iou" "{\"lender\":\"Adam\",\"borrower\":\"Bob\",\"amount\":2}"
                                    |> Expect.equal "{\"users\":[{\"name\":\"Adam\",\"owes\":{\"Bob\":1},\"owed_by\":{},\"balance\":-1},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{\"Adam\":1},\"balance\":1}]}"
            , skip <|
                test "lender owes borrower less than new loan" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{\"Bob\":3},\"owed_by\":{},\"balance\":-3},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{\"Adam\":3},\"balance\":3}]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/iou" "{\"lender\":\"Adam\",\"borrower\":\"Bob\",\"amount\":4}"
                                    |> Expect.equal "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{\"Bob\":1},\"balance\":1},{\"name\":\"Bob\",\"owes\":{\"Adam\":1},\"owed_by\":{},\"balance\":-1}]}"
            , skip <|
                test "lender owes borrower same as new loan" <|
                    \() ->
                        case RestApi.buildDatabase "{\"users\":[{\"name\":\"Adam\",\"owes\":{\"Bob\":3},\"owed_by\":{},\"balance\":-3},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{\"Adam\":3},\"balance\":3}]}" of
                            Err error ->
                                Expect.fail ("== Database payload could not be parsed ==\n" ++ Decode.errorToString error)

                            Ok database ->
                                RestApi.post database "/iou" "{\"lender\":\"Adam\",\"borrower\":\"Bob\",\"amount\":3}"
                                    |> Expect.equal "{\"users\":[{\"name\":\"Adam\",\"owes\":{},\"owed_by\":{},\"balance\":0},{\"name\":\"Bob\",\"owes\":{},\"owed_by\":{},\"balance\":0}]}"
            ]
        ]
