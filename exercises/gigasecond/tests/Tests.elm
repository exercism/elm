module Tests exposing (date, tests)

import Date
import Expect
import Gigasecond exposing (add)
import Test exposing (..)


tests : Test
tests =
    describe "Gigasecond"
        [ describe "add"
            [ test "2011-04-25" <|
                \() ->
                    Expect.equal (date "2043-01-01T01:46:40") (Gigasecond.add (date "2011-04-25"))
            , skip <|
                test "1977-06-13" <|
                    \() ->
                        Expect.equal (date "2009-02-19T01:46:40") (Gigasecond.add (date "1977-06-13"))
            , skip <|
                test "1959-07-19" <|
                    \() ->
                        Expect.equal (date "1991-03-27T01:46:40") (Gigasecond.add (date "1959-07-19"))
            , skip <|
                test "full time specified" <|
                    \() ->
                        Expect.equal (date "2046-10-02T23:46:40") (Gigasecond.add (date "2015-01-24T22:00:00"))
            , skip <|
                test "full time with day roll-over" <|
                    \() ->
                        Expect.equal (date "2046-10-03T01:46:39") (Gigasecond.add (date "2015-01-24T23:59:59"))
            ]
        ]


date : String -> Date.Date
date input =
    case Date.fromString input of
        Ok date ->
            date

        Err reason ->
            Debug.crash reason
