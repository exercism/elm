module Tests exposing (tests)

import Expect
import Knapsack exposing (..)
import Test exposing (..)


tests : Test
tests =
    describe "Knapsack"
        [ test "no items" <|
            \() ->
                maximumValue 100 [] |> Expect.equal 0
        , skip <|
            test "one item, too heavy" <|
                \() ->
                    maximumValue 10 [ { weight = 100, value = 1 } ] |> Expect.equal 0
        , skip <|
            test "five items (cannot be greedy by weight)" <|
                \() ->
                    maximumValue 10
                        [ { weight = 2, value = 5 }
                        , { weight = 2, value = 5 }
                        , { weight = 2, value = 5 }
                        , { weight = 2, value = 5 }
                        , { weight = 10, value = 21 }
                        ]
                        |> Expect.equal 21
        , skip <|
            test "five items (cannot be greedy by value)" <|
                \() ->
                    maximumValue 10
                        [ { weight = 2, value = 20 }
                        , { weight = 2, value = 20 }
                        , { weight = 2, value = 20 }
                        , { weight = 2, value = 20 }
                        , { weight = 10, value = 50 }
                        ]
                        |> Expect.equal 80
        , skip <|
            test "example knapsack" <|
                \() ->
                    maximumValue 10
                        [ { weight = 5, value = 10 }
                        , { weight = 4, value = 40 }
                        , { weight = 6, value = 30 }
                        , { weight = 4, value = 50 }
                        ]
                        |> Expect.equal 90
        , skip <|
            test "8 items" <|
                \() ->
                    maximumValue 104
                        [ { weight = 25, value = 350 }
                        , { weight = 35, value = 400 }
                        , { weight = 45, value = 450 }
                        , { weight = 5, value = 20 }
                        , { weight = 25, value = 70 }
                        , { weight = 3, value = 8 }
                        , { weight = 2, value = 5 }
                        , { weight = 2, value = 5 }
                        ]
                        |> Expect.equal 900
        , skip <|
            test "15 items" <|
                \() ->
                    maximumValue 750
                        [ { weight = 70, value = 135 }
                        , { weight = 73, value = 139 }
                        , { weight = 77, value = 149 }
                        , { weight = 80, value = 150 }
                        , { weight = 82, value = 156 }
                        , { weight = 87, value = 163 }
                        , { weight = 90, value = 173 }
                        , { weight = 94, value = 184 }
                        , { weight = 98, value = 192 }
                        , { weight = 106, value = 201 }
                        , { weight = 110, value = 210 }
                        , { weight = 113, value = 214 }
                        , { weight = 115, value = 221 }
                        , { weight = 118, value = 229 }
                        , { weight = 120, value = 240 }
                        ]
                        |> Expect.equal 1458
        ]
