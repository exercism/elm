module Tests exposing (tests)

import Expect
import PaolasPrestigiousPizza exposing (..)
import Parser
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "PaolasPrestigiousPizza"
        [ describe "1"
            [ test "parse small price" <|
                \() ->
                    Parser.run priceParser "5€"
                        |> Expect.equal (Ok 5)
            , test "parse large price" <|
                \() ->
                    Parser.run priceParser "1234567890€"
                        |> Expect.equal (Ok 1234567890)
            , test "fail without the euro symbol" <|
                \() ->
                    Parser.run priceParser "5"
                        |> Expect.err
            ]
        , describe "2"
            [ test "parse vegetarian indicator" <|
                \() ->
                    Parser.run vegetarianParser "(v)"
                        |> Expect.equal (Ok True)
            , test "parse empty string" <|
                \() ->
                    Parser.run vegetarianParser ""
                        |> Expect.equal (Ok False)
            , test "spaces inside the brakets are invalid" <|
                \() ->
                    Parser.run vegetarianParser "( v )"
                        |> Expect.equal (Ok False)
            ]
        , describe "3"
            [ test "parse pizza name" <|
                \() ->
                    Parser.run wordParser "Caprese"
                        |> Expect.equal (Ok "Caprese")
            , test "parse ingredient name" <|
                \() ->
                    Parser.run wordParser "tuna"
                        |> Expect.equal (Ok "tuna")
            , test "non lowercase/uppercase ASCII are not included" <|
                \() ->
                    Parser.run wordParser "Formaggio (v)"
                        |> Expect.equal (Ok "Formaggio")
            , test "empty strings are valid words" <|
                \() ->
                    Parser.run wordParser ""
                        |> Expect.equal (Ok "")
            ]
        , describe "4"
            [ test "parse one ingredient" <|
                \() ->
                    Parser.run ingredientsParser "spinach"
                        |> Expect.equal (Ok [ "spinach" ])
            , test "parse two ingredients" <|
                \() ->
                    Parser.run ingredientsParser "spinach, mozzarella"
                        |> Expect.equal (Ok [ "spinach", "mozzarella" ])
            , test "parse many ingredients" <|
                \() ->
                    Parser.run ingredientsParser "tomato, ham, mushrooms, cantal, eggs"
                        |> Expect.equal (Ok [ "tomato", "ham", "mushrooms", "cantal", "eggs" ])
            , test "parse ingredients with extra spaces" <|
                \() ->
                    Parser.run ingredientsParser "tomato   ,    ham  ,       mushrooms"
                        |> Expect.equal (Ok [ "tomato", "ham", "mushrooms" ])
            , test "ignore non ASCII characters after an ingredient" <|
                \() ->
                    Parser.run ingredientsParser "spinach(fresh from the garden)"
                        |> Expect.equal (Ok [ "spinach" ])
            ]
        , describe "5"
            [ test "parse a vegetarian pizza" <|
                \() ->
                    Parser.run pizzaParser "Formaggio (v): tomato, emmental - 8€"
                        |> Expect.equal (Ok (Pizza "Formaggio" True [ "tomato", "emmental" ] 8))
            , test "parse a non-vegetarian pizza" <|
                \() ->
                    Parser.run pizzaParser "Regina: tomato, ham, mushrooms, cantal - 11€"
                        |> Expect.equal (Ok (Pizza "Regina" False [ "tomato", "ham", "mushrooms", "cantal" ] 11))
            , test "parse a pizza with extra spaces" <|
                \() ->
                    Parser.run pizzaParser "Regina  :     tomato   ,  ham ,     mushrooms,  cantal   -   11€   "
                        |> Expect.equal (Ok (Pizza "Regina" False [ "tomato", "ham", "mushrooms", "cantal" ] 11))
            , test "fail if colon is missing" <|
                \() ->
                    Parser.run pizzaParser "Regina tomato, ham, mushrooms, cantal - 11€"
                        |> Expect.err
            , test "fail if dash is missing" <|
                \() ->
                    Parser.run pizzaParser "Regina: tomato, ham, mushrooms, cantal, 11€"
                        |> Expect.err
            , test "fail if price is missing" <|
                \() ->
                    Parser.run pizzaParser "Regina: tomato, ham, mushrooms, cantal -"
                        |> Expect.err
            ]
        , describe "6"
            [ test "parse one pizza" <|
                \() ->
                    Parser.run menuParser "Formaggio (v): tomato, emmental - 8€"
                        |> Expect.equal (Ok [ Pizza "Formaggio" True [ "tomato", "emmental" ] 8 ])
            , test "parse two pizzas with no trailing newline" <|
                \() ->
                    "Formaggio (v): tomato, emmental - 8€\nRegina: tomato, ham, mushrooms, cantal - 11€"
                        |> Parser.run menuParser
                        |> Expect.equal
                            (Ok
                                [ Pizza "Formaggio" True [ "tomato", "emmental" ] 8
                                , Pizza "Regina" False [ "tomato", "ham", "mushrooms", "cantal" ] 11
                                ]
                            )
            , test "parse two pizzas with trailing newline" <|
                \() ->
                    """Formaggio (v): tomato, emmental - 8€
Regina: tomato, ham, mushrooms, cantal - 11€
"""
                        |> Parser.run menuParser
                        |> Expect.equal
                            (Ok
                                [ Pizza "Formaggio" True [ "tomato", "emmental" ] 8
                                , Pizza "Regina" False [ "tomato", "ham", "mushrooms", "cantal" ] 11
                                ]
                            )
            , test "parse many pizzas" <|
                \() ->
                    """Formaggio (v): tomato, emmental - 8€
Regina: tomato, ham, mushrooms, cantal - 11€
Tonno: tomato, tuna - 10€
Margherita (v): tomato, mozzarella - 7€
Caprese (v): tomato, spinach, mozzarella - 8€
Hawaii: tomato, pineapple, ham - 9€
"""
                        |> Parser.run menuParser
                        |> Expect.equal
                            (Ok
                                [ Pizza "Formaggio" True [ "tomato", "emmental" ] 8
                                , Pizza "Regina" False [ "tomato", "ham", "mushrooms", "cantal" ] 11
                                , Pizza "Tonno" False [ "tomato", "tuna" ] 10
                                , Pizza "Margherita" True [ "tomato", "mozzarella" ] 7
                                , Pizza "Caprese" True [ "tomato", "spinach", "mozzarella" ] 8
                                , Pizza "Hawaii" False [ "tomato", "pineapple", "ham" ] 9
                                ]
                            )
            , test "must reach the end of the text" <|
                \() ->
                    Parser.run menuParser "Formaggio (v): tomato, emmental - 8€\n[END]"
                        |> Expect.equal (Err [ { problem = Parser.ExpectingEnd, col = 1, row = 2 } ])
            ]
        , describe "7"
            [ test "parse multi-word ingredient" <|
                \() ->
                    Parser.run oneIngredientParser "fresh fish"
                        |> Expect.equal (Ok "fresh fish")
            , test "parse and trim ingredient" <|
                \() ->
                    Parser.run oneIngredientParser "     fresh fish     "
                        |> Expect.equal (Ok "fresh fish")
            , test "fail with message on empty string" <|
                \() ->
                    Parser.run oneIngredientParser ""
                        |> Expect.equal (Err [ { col = 1, problem = Parser.Problem "empty string", row = 1 } ])
            , test "parse ingredients with extra spaces" <|
                \() ->
                    Parser.run ingredientsParser "   tomato sauce  , fresh ham   ,     dried mushrooms"
                        |> Expect.equal (Ok [ "tomato sauce", "fresh ham", "dried mushrooms" ])
            , test "parse many ingredients" <|
                \() ->
                    Parser.run ingredientsParser "tomato sauce, fresh ham, dried mushrooms, runny eggs"
                        |> Expect.equal (Ok [ "tomato sauce", "fresh ham", "dried mushrooms", "runny eggs" ])
            , test "parse a pizza with no ingredients" <|
                \() ->
                    Parser.run pizzaParser "Triste (v): - 1€"
                        |> Expect.equal (Ok (Pizza "Triste" True [] 1))
            , test "parse many pizzas" <|
                \() ->
                    """Formaggio (v): tomato sauce, extra emmental - 8€
Regina: tomato sauce, ham, dried mushrooms, cantal - 11€
Tonno: tomato sauce, tuna - 10€
Margherita (v): tomato sauce, mozzarella - 7€
Caprese (v): tomato sauce, spinach, mozzarella - 8€
Hawaii: tomato sauce, pineapple, ham - 9€
"""
                        |> Parser.run menuParser
                        |> Expect.equal
                            (Ok
                                [ Pizza "Formaggio" True [ "tomato sauce", "extra emmental" ] 8
                                , Pizza "Regina" False [ "tomato sauce", "ham", "dried mushrooms", "cantal" ] 11
                                , Pizza "Tonno" False [ "tomato sauce", "tuna" ] 10
                                , Pizza "Margherita" True [ "tomato sauce", "mozzarella" ] 7
                                , Pizza "Caprese" True [ "tomato sauce", "spinach", "mozzarella" ] 8
                                , Pizza "Hawaii" False [ "tomato sauce", "pineapple", "ham" ] 9
                                ]
                            )
            ]
        ]
