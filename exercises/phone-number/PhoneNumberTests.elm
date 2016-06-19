module Main exposing (..)

import ElmTest exposing (..)
import PhoneNumber exposing (getNumber, prettyPrint)


tests : Test
tests =
    suite "PhoneNumber"
        [ test "cleans number"
            (assertEqual (Just "1234567890") (getNumber "(123) 456-7890"))
        , test "cleans number with dots"
            (assertEqual (Just "1234567890") (getNumber "123.456.7890"))
        , test "valid when 11 digits and first is 1"
            (assertEqual (Just "1234567890") (getNumber "11234567890"))
        , test "invalid when 11 digits"
            (assertEqual Nothing (getNumber "21234567890"))
        , test "invalid when 9 digits"
            (assertEqual Nothing (getNumber "123456789"))
        , test "invalid when 12 digits"
            (assertEqual Nothing (getNumber "123456789012"))
        , test "invalid when empty"
            (assertEqual Nothing (getNumber ""))
        , test "invalid when no digits present"
            (assertEqual Nothing (getNumber " (-) "))
        , test "valid with leading characters"
            (assertEqual (Just "1234567890") (getNumber "my number is 123 456 7890"))
        , test "valid with trailing characters"
            (assertEqual (Just "1234567890") (getNumber "123 456 7890 - bob"))
        , test "pretty print"
            (assertEqual (Just "(123) 456-7890") (prettyPrint "1234567890"))
        , test "pretty print with full us phone number"
            (assertEqual (Just "(123) 456-7890") (prettyPrint "11234567890"))
        ]


main : Program Never
main =
    runSuite tests
