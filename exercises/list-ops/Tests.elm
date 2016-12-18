port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
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
                \() -> Expect.equal 4 (ListOps.length (List.range 1 4))
            ]
        , describe "reverse"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.reverse [])
            , test "non-empty list" <|
                \() -> Expect.equal [ 4, 3, 2, 1 ] (ListOps.reverse (List.range 1 4))
            ]
        , describe "map"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.map ((+) 1) [])
            , test "non-empty list" <|
                \() -> Expect.equal (List.range 2 5) (ListOps.map ((+) 1) (List.range 1 4))
            ]
        , describe "filter"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.filter (\_ -> True) [])
            , test "non-empty list" <|
                \() -> Expect.equal [ 2, 4 ] (ListOps.filter (\x -> x % 2 == 0) (List.range 1 4))
            ]
        , describe "foldl"
            [ test "empty list" <|
                \() -> Expect.equal 0 (ListOps.foldl (+) 0 [])
            , test "non-empty list" <|
                \() -> Expect.equal 10 (ListOps.foldl (+) 0 (List.range 1 4))
            , test "direction" <|
                \() -> Expect.equal [ 4, 3, 2, 1 ] (ListOps.foldl (::) [] (List.range 1 4))
            ]
        , describe "foldr"
            [ test "empty list" <|
                \() -> Expect.equal 0 (ListOps.foldr (+) 0 [])
            , test "non-empty list" <|
                \() -> Expect.equal 10 (ListOps.foldr (+) 0 (List.range 1 4))
            , test "direction" <|
                \() -> Expect.equal (List.range 1 4) (ListOps.foldr (::) [] (List.range 1 4))
            ]
        , describe "append"
            [ test "empty lists" <|
                \() -> Expect.equal [] (ListOps.append [] [])
            , test "empty and non-empty lists" <|
                \() -> Expect.equal (List.range 1 4) (ListOps.append [] (List.range 1 4))
            , test "non-empty and empty lists" <|
                \() -> Expect.equal (List.range 1 4) (ListOps.append (List.range 1 4) [])
            , test "non-empty lists" <|
                \() -> Expect.equal (List.range 1 8) (ListOps.append (List.range 1 4) (List.range 5 8))
            ]
        , describe "concat"
            [ test "empty list" <|
                \() -> Expect.equal [] (ListOps.concat [])
            , test "list of lists" <|
                \() -> Expect.equal (List.range 1 10) (ListOps.concat [ List.range 1 3, [], List.range 4 7, List.range 8 10 ])
            ]
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
