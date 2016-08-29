port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Date
import Gigasecond exposing (add)


tests : Test
tests =
    describe "Gigasecond"
        [ describe "add"
            [ test "2011-04-25" <|
                \() ->
                    Expect.equal (actual "2011-04-25") (expected "2043-01-01T01:46:40")
            , test "1977-06-13" <|
                \() ->
                    Expect.equal (actual "1977-06-13") (expected "2009-02-19T01:46:40")
            , test "1959-07-19" <|
                \() ->
                    Expect.equal (actual "1959-07-19") (expected "1991-03-27T01:46:40")
            , test "full time specified" <|
                \() ->
                    Expect.equal (actual "2015-01-24T22:00:00") (expected "2046-10-02T23:46:40")
            , test "full time with day roll-over" <|
                \() ->
                    Expect.equal (actual "2015-01-24T23:59:59") (expected "2046-10-03T01:46:39")
            ]
        ]


actual : String -> Result String Date.Date
actual =
    Date.fromString >> Result.map Gigasecond.add


expected : String -> Result String Date.Date
expected =
    Date.fromString


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
