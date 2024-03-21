module Tests exposing (tests)

import Allergies exposing (Allergy)
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    -- Given a number and a substance, indicate whether Tom is allergic to that substance.
    describe "Allergies"
        [ describe "testing for eggs allergy"
            [ test "not allergic to anything" <|
                \() ->
                    Allergies.isAllergicTo Allergies.Eggs 0
                        |> Expect.equal False
            , skip <|
                test "allergic only to eggs" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Eggs 1
                            |> Expect.equal True
            , skip <|
                test "allergic to eggs and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Eggs 3
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not eggs" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Eggs 2
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Eggs 255
                            |> Expect.equal True
            ]
        , describe "testing for peanuts allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Peanuts 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to peanuts" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Peanuts 2
                            |> Expect.equal True
            , skip <|
                test "allergic to peanuts and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Peanuts 7
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not peanuts" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Peanuts 5
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Peanuts 255
                            |> Expect.equal True
            ]
        , describe "testing for shellfish allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Shellfish 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to shellfish" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Shellfish 4
                            |> Expect.equal True
            , skip <|
                test "allergic to shellfish and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Shellfish 14
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not shellfish" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Shellfish 10
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Shellfish 255
                            |> Expect.equal True
            ]
        , describe "testing for strawberries allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Strawberries 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to strawberries" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Strawberries 8
                            |> Expect.equal True
            , skip <|
                test "allergic to strawberries and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Strawberries 28
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not strawberries" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Strawberries 20
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Strawberries 255
                            |> Expect.equal True
            ]
        , describe "testing for tomatoes allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Tomatoes 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to tomatoes" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Tomatoes 16
                            |> Expect.equal True
            , skip <|
                test "allergic to tomatoes and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Tomatoes 56
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not tomatoes" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Tomatoes 40
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Tomatoes 255
                            |> Expect.equal True
            ]
        , describe "testing for chocolate allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Chocolate 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to chocolate" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Chocolate 32
                            |> Expect.equal True
            , skip <|
                test "allergic to chocolate and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Chocolate 112
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not chocolate" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Chocolate 80
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Chocolate 255
                            |> Expect.equal True
            ]
        , describe "testing for pollen allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Pollen 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to pollen" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Pollen 64
                            |> Expect.equal True
            , skip <|
                test "allergic to pollen and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Pollen 224
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not pollen" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Pollen 160
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Pollen 255
                            |> Expect.equal True
            ]
        , describe "testing for cats allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Cats 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to cats" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Cats 128
                            |> Expect.equal True
            , skip <|
                test "allergic to cats and something else" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Cats 192
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not cats" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Cats 64
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Allergies.Cats 255
                            |> Expect.equal True
            ]
        , -- Given a number, list all things Tom is allergic to
          describe "list when:"
            [ skip <|
                test "no allergies" <|
                    \() ->
                        Allergies.toList 0
                            |> Expect.equal []
            , skip <|
                test "just eggs" <|
                    \() ->
                        Allergies.toList 1
                            |> Expect.equal [ Allergies.Eggs ]
            , skip <|
                test "just peanuts" <|
                    \() ->
                        Allergies.toList 2
                            |> Expect.equal [ Allergies.Peanuts ]
            , skip <|
                test "just strawberries" <|
                    \() ->
                        Allergies.toList 8
                            |> Expect.equal [ Allergies.Strawberries ]
            , skip <|
                test "eggs and peanuts" <|
                    \() ->
                        Allergies.toList 3
                            |> allergySort
                            |> Expect.equal (allergySort [ Allergies.Eggs, Allergies.Peanuts ])
            , skip <|
                test "more than eggs but not peanuts" <|
                    \() ->
                        Allergies.toList 5
                            |> allergySort
                            |> Expect.equal (allergySort [ Allergies.Eggs, Allergies.Shellfish ])
            , skip <|
                test "lots of stuff" <|
                    \() ->
                        Allergies.toList 248
                            |> allergySort
                            |> Expect.equal (allergySort [ Allergies.Strawberries, Allergies.Tomatoes, Allergies.Chocolate, Allergies.Pollen, Allergies.Cats ])
            , skip <|
                test "everything" <|
                    \() ->
                        Allergies.toList 255
                            |> allergySort
                            |> Expect.equal (allergySort [ Allergies.Eggs, Allergies.Peanuts, Allergies.Shellfish, Allergies.Strawberries, Allergies.Tomatoes, Allergies.Chocolate, Allergies.Pollen, Allergies.Cats ])
            , skip <|
                test "no allergen score parts" <|
                    \() ->
                        Allergies.toList 509
                            |> Expect.equal [ Allergies.Eggs, Allergies.Shellfish, Allergies.Strawberries, Allergies.Tomatoes, Allergies.Chocolate, Allergies.Pollen, Allergies.Cats ]
            , skip <|
                test "no allergen score parts without highest valid score" <|
                    \() ->
                        Allergies.toList 257
                            |> Expect.equal [ Allergies.Eggs ]
            ]
        ]


allergySort : List Allergy -> List Allergy
allergySort =
    let
        allergyOrder allergy =
            case allergy of
                Allergies.Eggs ->
                    1

                Allergies.Peanuts ->
                    2

                Allergies.Shellfish ->
                    3

                Allergies.Strawberries ->
                    4

                Allergies.Tomatoes ->
                    5

                Allergies.Chocolate ->
                    6

                Allergies.Pollen ->
                    7

                Allergies.Cats ->
                    8
    in
    List.sortBy allergyOrder
