module Tests exposing (tests)

import Expect
import PhoneNumber exposing (getNumber)
import Test exposing (..)


tests : Test
tests =
    describe "PhoneNumber"
        [ test "cleans the number" <|
            \() -> Expect.equal (Just "2234567890") (getNumber "(223) 456-7890")
        , skip <|
            test "cleans numbers with dots" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "223.456.7890")
        , skip <|
            test "cleans numbers with multiple spaces" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "223 456   7890   ")
        , skip <|
            test "invalid when 9 digits" <|
                \() -> Expect.equal Nothing (getNumber "123456789")
        , skip <|
            test "invalid when 11 digits does not start with a 1" <|
                \() -> Expect.equal Nothing (getNumber "22234567890")
        , skip <|
            test "valid when 11 digits and starting with 1" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "12234567890")
        , skip <|
            test "valid when 11 digits and starting with 1 even with punctuation" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "+1 (223) 456-7890")
        , skip <|
            test "invalid when more than 11 digits" <|
                \() -> Expect.equal Nothing (getNumber "321234567890")
        , skip <|
            test "invalid with letters" <|
                \() -> Expect.equal Nothing (getNumber "523-abc-7890")
        , skip <|
            test "invalid with punctuations" <|
                \() -> Expect.equal Nothing (getNumber "523-@:!-7890")
        , skip <|
            test "invalid if area code starts with 0" <|
                \() -> Expect.equal Nothing (getNumber "(023) 456-7890")
        , skip <|
            test "invalid if area code starts with 1" <|
                \() -> Expect.equal Nothing (getNumber "(123) 456-7890")
        , skip <|
            test "invalid if exchange code starts with 0" <|
                \() -> Expect.equal Nothing (getNumber "(223) 056-7890")
        , skip <|
            test "invalid if exchange code starts with 1" <|
                \() -> Expect.equal Nothing (getNumber "(223) 156-7890")
        , skip <|
            test "invalid if area code starts with 0 on valid 11-digit number" <|
                \() -> Expect.equal Nothing (getNumber "1 (023) 456-7890")
        , skip <|
            test "invalid if area code starts with 1 on valid 11-digit number" <|
                \() -> Expect.equal Nothing (getNumber "1 (123) 456-7890")
        , skip <|
            test "invalid if exchange code starts with 0 on valid 11-digit number" <|
                \() -> Expect.equal Nothing (getNumber "1 (223) 056-7890")
        , skip <|
            test "invalid if exchange code starts with 1 on valid 11-digit number" <|
                \() -> Expect.equal Nothing (getNumber "1 (223) 156-7890")
        ]
