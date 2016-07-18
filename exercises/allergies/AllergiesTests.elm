module Main exposing (..)

import ElmTest exposing (..)
import Allergies exposing (isAllergicTo, toList)
import List


tests : Test
tests =
    suite "Allergies"
        [ suite "isAllergicTo"
            [ suite "no allergies means not allergic"
                [ test "peanuts"
                    (assert (not (isAllergicTo "peanuts" 0)))
                , test "cats"
                    (assert (not (isAllergicTo "cats" 0)))
                , test "strawberries"
                    (assert (not (isAllergicTo "strawberries" 0)))
                ]
            , test "is allergic to eggs"
                (assert (isAllergicTo "eggs" 1))
            , suite "has the right allergies"
                [ test "eggs"
                    (assert (isAllergicTo "eggs" 5))
                , test "shellfish"
                    (assert (isAllergicTo "shellfish" 5))
                , test "strawberries"
                    (assert (not (isAllergicTo "strawberries" 5)))
                ]
            ]
        , suite "toList"
            [ test "no allergies at all"
                (assertEqual [] (toList (0)))
            , test "allergic to just peanuts"
                (assertEqual [ "peanuts" ] (toList (2)))
            , test "allergic to everything"
                (assertEqual (List.sort [ "eggs", "peanuts", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ])
                    (255 |> toList |> List.sort)
                )
            , test "ignore non allergen score parts"
                (assertEqual [ "eggs" ] (toList 257))
            , test "ignore non allergen score parts"
                (assertEqual (List.sort [ "eggs", "shellfish", "strawberries", "tomatoes", "chocolate", "pollen", "cats" ])
                    (509 |> toList |> List.sort)
                )
            ]
        ]


main : Program Never
main =
    runSuite tests
