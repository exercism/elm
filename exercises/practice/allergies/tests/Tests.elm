module Tests exposing (tests)

import Allergies exposing (Allergy(..))
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Allergies"
        [ describe "testing for eggs allergy"
            [ test "not allergic to anything" <|
                \() ->
                    Allergies.isAllergicTo Eggs 0
                        |> Expect.equal False
            , skip <|
                test "allergic only to eggs" <|
                    \() ->
                        Allergies.isAllergicTo Eggs 1
                            |> Expect.equal True
            , skip <|
                test "allergic to eggs and something else" <|
                    \() ->
                        Allergies.isAllergicTo Eggs 3
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not eggs" <|
                    \() ->
                        Allergies.isAllergicTo Eggs 2
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Eggs 255
                            |> Expect.equal True
            ]
        , describe "testing for peanuts allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Peanuts 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to peanuts" <|
                    \() ->
                        Allergies.isAllergicTo Peanuts 2
                            |> Expect.equal True
            , skip <|
                test "allergic to peanuts and something else" <|
                    \() ->
                        Allergies.isAllergicTo Peanuts 7
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not peanuts" <|
                    \() ->
                        Allergies.isAllergicTo Peanuts 5
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Peanuts 255
                            |> Expect.equal True
            ]
        , describe "testing for shellfish allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Shellfish 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to shellfish" <|
                    \() ->
                        Allergies.isAllergicTo Shellfish 4
                            |> Expect.equal True
            , skip <|
                test "allergic to shellfish and something else" <|
                    \() ->
                        Allergies.isAllergicTo Shellfish 14
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not shellfish" <|
                    \() ->
                        Allergies.isAllergicTo Shellfish 10
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Shellfish 255
                            |> Expect.equal True
            ]
        , describe "testing for strawberries allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Strawberries 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to strawberries" <|
                    \() ->
                        Allergies.isAllergicTo Strawberries 8
                            |> Expect.equal True
            , skip <|
                test "allergic to strawberries and something else" <|
                    \() ->
                        Allergies.isAllergicTo Strawberries 28
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not strawberries" <|
                    \() ->
                        Allergies.isAllergicTo Strawberries 20
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Strawberries 255
                            |> Expect.equal True
            ]
        , describe "testing for tomatoes allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Tomatoes 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to tomatoes" <|
                    \() ->
                        Allergies.isAllergicTo Tomatoes 16
                            |> Expect.equal True
            , skip <|
                test "allergic to tomatoes and something else" <|
                    \() ->
                        Allergies.isAllergicTo Tomatoes 56
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not tomatoes" <|
                    \() ->
                        Allergies.isAllergicTo Tomatoes 40
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Tomatoes 255
                            |> Expect.equal True
            ]
        , describe "testing for chocolate allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Chocolate 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to chocolate" <|
                    \() ->
                        Allergies.isAllergicTo Chocolate 32
                            |> Expect.equal True
            , skip <|
                test "allergic to chocolate and something else" <|
                    \() ->
                        Allergies.isAllergicTo Chocolate 112
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not chocolate" <|
                    \() ->
                        Allergies.isAllergicTo Chocolate 80
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Chocolate 255
                            |> Expect.equal True
            ]
        , describe "testing for pollen allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Pollen 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to pollen" <|
                    \() ->
                        Allergies.isAllergicTo Pollen 64
                            |> Expect.equal True
            , skip <|
                test "allergic to pollen and something else" <|
                    \() ->
                        Allergies.isAllergicTo Pollen 224
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not pollen" <|
                    \() ->
                        Allergies.isAllergicTo Pollen 160
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Pollen 255
                            |> Expect.equal True
            ]
        , describe "testing for cats allergy"
            [ skip <|
                test "not allergic to anything" <|
                    \() ->
                        Allergies.isAllergicTo Cats 0
                            |> Expect.equal False
            , skip <|
                test "allergic only to cats" <|
                    \() ->
                        Allergies.isAllergicTo Cats 128
                            |> Expect.equal True
            , skip <|
                test "allergic to cats and something else" <|
                    \() ->
                        Allergies.isAllergicTo Cats 192
                            |> Expect.equal True
            , skip <|
                test "allergic to something, but not cats" <|
                    \() ->
                        Allergies.isAllergicTo Cats 64
                            |> Expect.equal False
            , skip <|
                test "allergic to everything" <|
                    \() ->
                        Allergies.isAllergicTo Cats 255
                            |> Expect.equal True
            ]
        , describe "list when:"
            [ skip <|
                test "no allergies" <|
                    \() ->
                        Allergies.toList 0
                            |> Expect.equal []
            , skip <|
                test "just eggs" <|
                    \() ->
                        Allergies.toList 1
                            |> Expect.equal [ Eggs ]
            , skip <|
                test "just peanuts" <|
                    \() ->
                        Allergies.toList 2
                            |> Expect.equal [ Peanuts ]
            , skip <|
                test "just strawberries" <|
                    \() ->
                        Allergies.toList 8
                            |> Expect.equal [ Strawberries ]
            , skip <|
                test "eggs and peanuts" <|
                    \() ->
                        Allergies.toList 3
                            |> allergySort
                            |> Expect.equal (allergySort [ Eggs, Peanuts ])
            , skip <|
                test "more than eggs but not peanuts" <|
                    \() ->
                        Allergies.toList 5
                            |> allergySort
                            |> Expect.equal (allergySort [ Eggs, Shellfish ])
            , skip <|
                test "lots of stuff" <|
                    \() ->
                        Allergies.toList 248
                            |> allergySort
                            |> Expect.equal (allergySort [ Strawberries, Tomatoes, Chocolate, Pollen, Cats ])
            , skip <|
                test "everything" <|
                    \() ->
                        Allergies.toList 255
                            |> allergySort
                            |> Expect.equal (allergySort [ Eggs, Peanuts, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats ])
            , skip <|
                test "no allergen score parts" <|
                    \() ->
                        Allergies.toList 509
                            |> Expect.equal [ Eggs, Shellfish, Strawberries, Tomatoes, Chocolate, Pollen, Cats ]
            , skip <|
                test "no allergen score parts without highest valid score" <|
                    \() ->
                        Allergies.toList 257
                            |> Expect.equal [ Eggs ]
            ]
        ]


allergySort : List Allergy -> List Allergy
allergySort =
    let
        allergyOrder allergy =
            case allergy of
                Eggs ->
                    1

                Peanuts ->
                    2

                Shellfish ->
                    3

                Strawberries ->
                    4

                Tomatoes ->
                    5

                Chocolate ->
                    6

                Pollen ->
                    7

                Cats ->
                    8
    in
    List.sortBy allergyOrder
