port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import ListOps exposing (..)


tests : Test
tests =
    describe "List Ops"
        [ describe "length"
            [ test "empty list" <|
                \() -> Expect.equal 0 (ListOps.length [])
            , test "non-empty list" <|
                \() -> Expect.equal 4 (ListOps.length [1..4])
            ]
        , describe "reverse"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.reverse [])
            , test "non-empty list" <|
                \() -> Expect.equal [ 4, 3, 2, 1 ] (ListOps.reverse [1..4])
            ]
        , describe "map"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.map ((+) 1) [])
            , test "non-empty list" <|
                \() -> Expect.equal [2..5] (ListOps.map ((+) 1) [1..4])
            ]
        , describe "filter"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.filter (\_ -> True) [])
            , test "non-empty list" <|
                \() -> Expect.equal [ 2, 4 ] (ListOps.filter (\x -> x % 2 == 0) [1..4])
            ]
        , describe "foldl"
            [ test "empty list" <|
                \() -> Expect.equal 0 (ListOps.foldl (+) 0 [])
            , test "non-empty list" <|
                \() -> Expect.equal 10 (ListOps.foldl (+) 0 [1..4])
            , test "direction" <|
                \() -> Expect.equal [ 4, 3, 2, 1 ] (ListOps.foldl (::) [] [1..4])
            ]
        , describe "foldr"
            [ test "empty list" <|
                \() -> Expect.equal 0 (ListOps.foldr (+) 0 [])
            , test "non-empty list" <|
                \() -> Expect.equal 10 (ListOps.foldr (+) 0 [1..4])
            , test "direction" <|
                \() -> Expect.equal [1..4] (ListOps.foldr (::) [] [1..4])
            ]
        , describe "append"
            [ test "empty lists" <|
                \() -> Expect.equal [] (ListOps.append [] [])
            , test "empty and non-empty lists" <|
                \() -> Expect.equal [1..4] (ListOps.append [] [1..4])
            , test "non-empty and empty lists" <|
                \() -> Expect.equal [1..4] (ListOps.append [1..4] [])
            , test "non-empty lists" <|
                \() -> Expect.equal [1..8] (ListOps.append [1..4] [5..8])
            ]
        , describe "concat"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.concat [])
            , test "list of lists" <|
                \() -> Expect.equal [1..10] (ListOps.concat [ [1..3], [], [4..7], [8..10] ])
            ]
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
