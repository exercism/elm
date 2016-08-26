port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Gigasecond exposing (add)


tests : Test
tests =
    describe "Gigasecond"
        [ describe "add"
            [ test "2011-04-25" <|
                \() ->
                    Expect.equal (Ok "2043-01-01T01:46:40") (Gigasecond.add "2011-04-25")
            , test "1977-06-13" <|
                \() ->
                    Expect.equal (Ok "2009-02-19T01:46:40") (Gigasecond.add "1977-06-13")
            , test "1959-07-19" <|
                \() ->
                    Expect.equal (Ok "1991-03-27T01:46:40") (Gigasecond.add "1959-07-19")
            , test "full time specified" <|
                \() ->
                    Expect.equal (Ok "2046-10-02T23:46:40") (Gigasecond.add "2015-01-24T22:00:00")
            , test "full time with day roll-over" <|
                \() ->
                    Expect.equal (Ok "2046-10-03T01:46:39") (Gigasecond.add "2015-01-24T23:59:59")
            ]
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
