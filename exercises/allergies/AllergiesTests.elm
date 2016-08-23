port module Main exposing (..)

import Test.Runner.Node exposing (run)
import Json.Encode exposing (Value)
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
                , test "cats" <|
                    \() -> Expect.equal False (isAllergicTo "cats" 0)
                , test "strawberries" <|
                    \() -> Expect.equal False (isAllergicTo "strawberries" 0)
                ]
            , test "is allergic to eggs" <|
                \() -> Expect.equal True (isAllergicTo "eggs" 1)
            , describe "has the right allergies"
                [ test "eggs" <|
                    \() -> Expect.equal True (isAllergicTo "eggs" 5)
                , test "shellfish" <|
                    \() -> Expect.equal True (isAllergicTo "shellfish" 5)
                , test "strawberries" <|
                    \() -> Expect.equal False (isAllergicTo "strawberries" 5)
                ]
            ]
        , describe "toList"
            [ test "no allergies at all" <|
                \() -> Expect.equal [] (toList (0))
            , test "allergic to just peanuts" <|
                \() -> Expect.equal [ "peanuts" ] (toList (2))
            , test "allergic to everything" <|
                \() ->
                    Expect.equal (List.sort [ "eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ])
                        (255 |> toList |> List.sort)
            , test "ignore non allergen score parts" <|
                \() -> Expect.equal [ "eggs" ] (toList 257)
            , test "ignore non allergen score parts" <|
                \() ->
                    Expect.equal (List.sort [ "eggs", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ])
                        (509 |> toList |> List.sort)
            ]
        ]


main : Program Value
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
