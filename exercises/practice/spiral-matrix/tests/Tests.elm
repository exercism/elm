module Tests exposing (tests)

import Expect
import SpiralMatrix
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "SpiralMatrix"
        [ -- skip <|
          test "empty spiral" <|
            \() ->
                SpiralMatrix.spiralMatrix 0
                    |> Expect.equal []
        , skip <|
            test "trivial spiral" <|
                \() ->
                    SpiralMatrix.spiralMatrix 1
                        |> Expect.equal [ [ 1 ] ]
        , skip <|
            test "spiral of size 2" <|
                \() ->
                    SpiralMatrix.spiralMatrix 2
                        |> Expect.equal
                            [ [ 1, 2 ]
                            , [ 4, 3 ]
                            ]
        , skip <|
            test "spiral of size 3" <|
                \() ->
                    SpiralMatrix.spiralMatrix 3
                        |> Expect.equal
                            [ [ 1, 2, 3 ]
                            , [ 8, 9, 4 ]
                            , [ 7, 6, 5 ]
                            ]
        , skip <|
            test "spiral of size 4" <|
                \() ->
                    SpiralMatrix.spiralMatrix 4
                        |> Expect.equal
                            [ [ 1, 2, 3, 4 ]
                            , [ 12, 13, 14, 5 ]
                            , [ 11, 16, 15, 6 ]
                            , [ 10, 9, 8, 7 ]
                            ]
        , skip <|
            test "spiral of size 5" <|
                \() ->
                    SpiralMatrix.spiralMatrix 5
                        |> Expect.equal
                            [ [ 1, 2, 3, 4, 5 ]
                            , [ 16, 17, 18, 19, 6 ]
                            , [ 15, 24, 25, 20, 7 ]
                            , [ 14, 23, 22, 21, 8 ]
                            , [ 13, 12, 11, 10, 9 ]
                            ]
        ]
