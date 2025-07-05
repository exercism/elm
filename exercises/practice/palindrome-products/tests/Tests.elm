module Tests exposing (tests)

import Expect
import PalindromeProducts
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "PalindromeProducts"
        [ -- skip <|
          test "find the smallest palindrome from single digit factors" <|
            \() ->
                PalindromeProducts.smallest 1 9
                    |> Expect.equal (Ok (Just { value = 1, factors = [ ( 1, 1 ) ] }))
        , skip <|
            test "find the largest palindrome from single digit factors" <|
                \() ->
                    PalindromeProducts.largest 1 9
                        |> Expect.equal (Ok (Just { value = 9, factors = [ ( 1, 9 ), ( 3, 3 ) ] }))
        , skip <|
            test "find the smallest palindrome from double digit factors" <|
                \() ->
                    PalindromeProducts.smallest 10 99
                        |> Expect.equal (Ok (Just { value = 121, factors = [ ( 11, 11 ) ] }))
        , skip <|
            test "find the largest palindrome from double digit factors" <|
                \() ->
                    PalindromeProducts.largest 10 99
                        |> Expect.equal (Ok (Just { value = 9009, factors = [ ( 91, 99 ) ] }))
        , skip <|
            test "find the smallest palindrome from triple digit factors" <|
                \() ->
                    PalindromeProducts.smallest 100 999
                        |> Expect.equal (Ok (Just { value = 10201, factors = [ ( 101, 101 ) ] }))
        , skip <|
            test "find the largest palindrome from triple digit factors" <|
                \() ->
                    PalindromeProducts.largest 100 999
                        |> Expect.equal (Ok (Just { value = 906609, factors = [ ( 913, 993 ) ] }))
        , skip <|
            test "find the smallest palindrome from four digit factors" <|
                \() ->
                    PalindromeProducts.smallest 1000 9999
                        |> Expect.equal (Ok (Just { value = 1002001, factors = [ ( 1001, 1001 ) ] }))
        , skip <|
            test "find the largest palindrome from four digit factors" <|
                \() ->
                    PalindromeProducts.largest 1000 9999
                        |> Expect.equal (Ok (Just { value = 99000099, factors = [ ( 9901, 9999 ) ] }))
        , skip <|
            test "empty result for smallest if no palindrome in the range" <|
                \() ->
                    PalindromeProducts.smallest 1002 1003
                        |> Expect.equal (Ok Nothing)
        , skip <|
            test "empty result for largest if no palindrome in the range" <|
                \() ->
                    PalindromeProducts.largest 15 15
                        |> Expect.equal (Ok Nothing)
        , skip <|
            test "error result for smallest if min is more than max" <|
                \() ->
                    PalindromeProducts.smallest 10000 1
                        |> Expect.equal (Err "min must be <= max")
        , skip <|
            test "error result for largest if min is more than max" <|
                \() ->
                    PalindromeProducts.largest 2 1
                        |> Expect.equal (Err "min must be <= max")
        , skip <|
            test "smallest product does not use the smallest factor" <|
                \() ->
                    PalindromeProducts.smallest 3215 4000
                        |> Expect.equal (Ok (Just { value = 10988901, factors = [ ( 3297, 3333 ) ] }))
        ]
