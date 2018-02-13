module Tests exposing (..)

import Expect
import PhoneNumber exposing (getNumber, prettyPrint)
import Test exposing (..)


tests : Test
tests =
    describe "PhoneNumber"
        [ test "cleans number" <|
            \() -> Expect.equal (Just "2234567890") (getNumber "(223) 456-7890")
        , skip <|
            test "invalid when empty" <|
                \() -> Expect.equal Nothing (getNumber "")
        , skip <|
            test "cleans number with dots" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "223.456.7890")
        , skip <|
            test "invalid when 9 digits" <|
                \() -> Expect.equal Nothing (getNumber "223456789")
        , skip <|
            test "cleans number with multiple spaces" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "223 456   7890")
        , skip <|
            test "invalid when 12 digits" <|
                \() -> Expect.equal Nothing (getNumber "223456789012")
        , skip <|
            test "valid when 11 digits and first is 1" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "12234567890")
        , skip <|
            test "invalid when 11 digits and first is not 1" <|
                \() -> Expect.equal Nothing (getNumber "22234567890")
        , skip <|
            test "valid when 11 digits and first is 1 with punctuation" <|
                \() -> Expect.equal (Just "2234567890") (getNumber "+1 (223) 456-7890")
        , skip <|
            test "invalid with letters" <|
                \() -> Expect.equal Nothing (getNumber "223-abc-789012")
        , skip <|
            test "invalid with multiple punctuation marks" <|
                \() -> Expect.equal Nothing (getNumber "223-@:!-789012")
        , skip <|
            test "invalid when area code starts with 1" <|
                \() -> Expect.equal Nothing (getNumber "(123) 456-7890")
        , skip <|
            test "invalid when area code starts with 0" <|
                \() -> Expect.equal Nothing (getNumber "(023) 456-7890")
        , skip <|
            test "invalid when exchange code starts with 1" <|
                \() -> Expect.equal Nothing (getNumber "(223) 156-7890")
        , skip <|
            test "invalid when exchange code starts with 0" <|
                \() -> Expect.equal Nothing (getNumber "(223) 056-7890")
        , skip <|
            test "invalid when N in exchange code is 1" <|
                \() -> Expect.equal Nothing (getNumber "2341567890")
        , skip <|
            test "invalid when no digits present" <|
                \() -> Expect.equal Nothing (getNumber " (-) ")
        , skip <|
            test "pretty print" <|
                \() -> Expect.equal (Just "(223) 456-7890") (prettyPrint "2234567890")
        , skip <|
            test "pretty print with full us phone number" <|
                \() -> Expect.equal (Just "(223) 456-7890") (prettyPrint "12234567890")
        ]
