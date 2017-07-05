module Tests exposing (..)

import Test exposing (..)
import Expect
import Allergies exposing (isAllergicTo, toList)
import List


tests : Test
tests =
    describe "Allergies"
        [ describe "isAllergicTo"
            [ describe "no allergies means not allergic"
                [ test "peanuts" <|
                    \() -> Expect.equal False (isAllergicTo "peanuts" 0)
                , skip <|
                    test "cats" <|
                        \() -> Expect.equal False (isAllergicTo "cats" 0)
                , skip <|
                    test "strawberries" <|
                        \() -> Expect.equal False (isAllergicTo "strawberries" 0)
                ]
            , skip <|
                test "is allergic to eggs" <|
                    \() -> Expect.equal True (isAllergicTo "eggs" 1)
            , describe "has the right allergies"
                [ skip <|
                    test "eggs" <|
                        \() -> Expect.equal True (isAllergicTo "eggs" 5)
                , skip <|
                    test "shellfish" <|
                        \() -> Expect.equal True (isAllergicTo "shellfish" 5)
                , skip <|
                    test "strawberries" <|
                        \() -> Expect.equal False (isAllergicTo "strawberries" 5)
                ]
            ]
        , describe "toList"
            [ skip <|
                test "no allergies at all" <|
                    \() -> Expect.equal [] (toList (0))
            , skip <|
                test "allergic to just peanuts" <|
                    \() -> Expect.equal [ "peanuts" ] (toList (2))
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Expect.equal (List.sort [ "eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ])
                            (255 |> toList |> List.sort)
            , skip <|
                test "ignore non allergen score parts" <|
                    \() -> Expect.equal [ "eggs" ] (toList 257)
            , skip <|
                test "ignore all non allergen score parts" <|
                    \() ->
                        Expect.equal (List.sort [ "eggs", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ])
                            (509 |> toList |> List.sort)
            ]
        ]
