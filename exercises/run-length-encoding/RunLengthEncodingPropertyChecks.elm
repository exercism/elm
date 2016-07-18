module RunLengthEncodingPropertyChecks exposing (propertyTests)

import ElmTest
import Check exposing (suite, claim, that, is, for, quickCheck)
import Check.Producer as P
import Check.Test
import RunLengthEncoding exposing (decode, encode)
import String as S
import Char


{-
   Currently disabled until elm-check is updated to support Elm 0.17

   Welcome! This is a property based test which will generate a bunch of random
   test cases in an attempt to find edge cases in your solution. If all goes well,
   any code that passes the regular tests should be fine here as well. If it goes
   less well, this should hopefully narrow the failure down to a useful test case.

   Good luck!
-}


claims : Check.Claim
claims =
    suite "List Reverse"
        [ claim "Encoding and decoding yields the original string"
            `that` (\input -> decode (encode (S.concat input)))
            `is` S.concat
            `for` inputProducer
        ]


inputProducer : P.Producer (List String)
inputProducer =
    P.tuple ( P.rangeInt 0 1001, upperCaseLetter )
        |> P.convert (\( n, c ) -> S.repeat n (S.fromChar c))
            (\s ->
                ( S.length s
                , S.toList s |> List.head |> crashIfNothing
                )
            )
        |> P.list


upperCaseLetter : P.Producer Char
upperCaseLetter =
    P.filter Char.isUpper P.upperCaseChar


crashIfNothing : Maybe a -> a
crashIfNothing a =
    case a of
        Just a ->
            a

        Nothing ->
            Debug.crash "Nothing!"


propertyTests : ElmTest.Test
propertyTests =
    Check.Test.evidenceToTest (quickCheck claims)
