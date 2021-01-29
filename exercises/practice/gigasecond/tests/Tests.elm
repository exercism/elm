module Tests exposing (tests)

import Expect
import Gigasecond exposing (add)
import Iso8601
import Parser
import Test exposing (..)
import Time


tests : Test
tests =
    describe "Gigasecond"
        [ describe "add"
            [ test "2011-04-25" <|
                \() ->
                    Expect.equal "2043-01-01T01:46:40.000Z"
                        (gigasecond "2011-04-25")
            , skip <|
                test "1977-06-13" <|
                    \() ->
                        Expect.equal "2009-02-19T01:46:40.000Z"
                            (gigasecond "1977-06-13")
            , skip <|
                test "1959-07-19" <|
                    \() ->
                        Expect.equal "1991-03-27T01:46:40.000Z"
                            (gigasecond "1959-07-19")
            , skip <|
                test "full time specified" <|
                    \() ->
                        Expect.equal "2046-10-02T23:46:40.000Z"
                            (gigasecond "2015-01-24T22:00:00.000Z")
            , skip <|
                test "full time with day roll-over" <|
                    \() ->
                        Expect.equal "2046-10-03T01:46:39.000Z"
                            (gigasecond "2015-01-24T23:59:59.000Z")
            ]
        ]


gigasecond : String -> String
gigasecond date =
    case Iso8601.toTime date of
        Ok posix ->
            posix
                |> Gigasecond.add
                |> Iso8601.fromTime

        _ ->
            ""
