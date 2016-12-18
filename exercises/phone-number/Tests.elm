port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import PhoneNumber exposing (getNumber, prettyPrint)


tests : Test
tests =
    describe "PhoneNumber"
        [ test "cleans number" <|
            \() -> Expect.equal (Just "1234567890") (getNumber "(123) 456-7890")
        , test "cleans number with dots" <|
            \() -> Expect.equal (Just "1234567890") (getNumber "123.456.7890")
        , test "valid when 11 digits and first is 1" <|
            \() -> Expect.equal (Just "1234567890") (getNumber "11234567890")
        , test "invalid when 11 digits" <|
            \() -> Expect.equal Nothing (getNumber "21234567890")
        , test "invalid when 9 digits" <|
            \() -> Expect.equal Nothing (getNumber "123456789")
        , test "invalid when 12 digits" <|
            \() -> Expect.equal Nothing (getNumber "123456789012")
        , test "invalid when empty" <|
            \() -> Expect.equal Nothing (getNumber "")
        , test "invalid when no digits present" <|
            \() -> Expect.equal Nothing (getNumber " (-) ")
        , test "valid with leading characters" <|
            \() -> Expect.equal (Just "1234567890") (getNumber "my number is 123 456 7890")
        , test "valid with trailing characters" <|
            \() -> Expect.equal (Just "1234567890") (getNumber "123 456 7890 - bob")
        , test "pretty print" <|
            \() -> Expect.equal (Just "(123) 456-7890") (prettyPrint "1234567890")
        , test "pretty print with full us phone number" <|
            \() -> Expect.equal (Just "(123) 456-7890") (prettyPrint "11234567890")
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
