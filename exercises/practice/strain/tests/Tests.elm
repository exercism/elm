module Tests exposing (alwaysFalse, alwaysTrue, containsFive, even, isFirstLetter, odd, tests)

import Expect
import Strain exposing (discard, keep)
import String
import Test exposing (..)


even : Int -> Bool
even number =
    modBy 2 number == 0


odd : Int -> Bool
odd number =
    modBy 2 number == 1


isFirstLetter : String -> String -> Bool
isFirstLetter letter word =
    String.left 1 word == letter


alwaysTrue : a -> Bool
alwaysTrue _ =
    True


alwaysFalse : a -> Bool
alwaysFalse _ =
    False


containsFive : List Int -> Bool
containsFive l =
    List.member 5 l


tests : Test
tests =
    describe "Strain"
        [ test "empty keep" <|
            \() ->
                Expect.equal []
                    (keep alwaysTrue [])
        , skip <|
            test "keeps everything" <|
                \() ->
                    Expect.equal [ 1, 3, 5 ]
                        (keep alwaysTrue [ 1, 3, 5 ])
        , skip <|
            test "keeps nothing" <|
                \() ->
                    Expect.equal []
                        (keep alwaysFalse [ 1, 2, 3 ])
        , skip <|
            test "keeps first and last" <|
                \() ->
                    Expect.equal [ 1, 3 ]
                        (keep odd [ 1, 2, 3 ])
        , skip <|
            test "keeps neither first nor last" <|
                \() ->
                    Expect.equal [ 2 ]
                        (keep even [ 1, 2, 3 ])
        , skip <|
            test "keeps strings" <|
                \() ->
                    Expect.equal [ "zebra", "zombies", "zealot" ]
                        (keep (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        , skip <|
            test "keeps list" <|
                \() ->
                    Expect.equal
                        [ [ 5, 5, 5 ]
                        , [ 5, 1, 2 ]
                        , [ 1, 5, 2 ]
                        , [ 1, 2, 5 ]
                        ]
                        (keep containsFive
                            [ [ 1, 2, 3 ]
                            , [ 5, 5, 5 ]
                            , [ 5, 1, 2 ]
                            , [ 2, 1, 2 ]
                            , [ 1, 5, 2 ]
                            , [ 2, 2, 1 ]
                            , [ 1, 2, 5 ]
                            ]
                        )
        , skip <|
            test "empty discard" <|
                \() ->
                    Expect.equal []
                        (discard alwaysTrue [])
        , skip <|
            test "discards everything" <|
                \() ->
                    Expect.equal []
                        (discard alwaysTrue [ 1, 3, 5 ])
        , skip <|
            test "discards nothing" <|
                \() ->
                    Expect.equal [ 1, 3, 5 ]
                        (discard alwaysFalse [ 1, 3, 5 ])
        , skip <|
            test "discards first and last" <|
                \() ->
                    Expect.equal [ 2 ]
                        (discard odd [ 1, 2, 3 ])
        , skip <|
            test "discards neither first nor last" <|
                \() ->
                    Expect.equal [ 1, 3 ]
                        (discard even [ 1, 2, 3 ])
        , skip <|
            test "discards strings" <|
                \() ->
                    Expect.equal [ "apple", "banana", "cherimoya" ]
                        (discard (isFirstLetter "z") [ "apple", "zebra", "banana", "zombies", "cherimoya", "zealot" ])
        , skip <|
            test "discards list" <|
                \() ->
                    Expect.equal
                        [ [ 1, 2, 3 ]
                        , [ 2, 1, 2 ]
                        , [ 2, 2, 1 ]
                        ]
                        (discard containsFive
                            [ [ 1, 2, 3 ]
                            , [ 5, 5, 5 ]
                            , [ 5, 1, 2 ]
                            , [ 2, 1, 2 ]
                            , [ 1, 5, 2 ]
                            , [ 2, 2, 1 ]
                            , [ 1, 2, 5 ]
                            ]
                        )
        ]
