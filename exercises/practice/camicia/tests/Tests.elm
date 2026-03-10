module Tests exposing (tests)

import Camicia exposing (Card(..), Status(..))
import Expect
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Camicia"
        [ -- skip <|
          test "two cards, one trick" <|
            \() ->
                Camicia.simulateGame
                    [ Two ]
                    [ Three ]
                    |> Expect.equal { status = Finished, cards = 2, tricks = 1 }
        , skip <|
            test "three cards, one trick" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Four ]
                        [ Three ]
                        |> Expect.equal { status = Finished, cards = 3, tricks = 1 }
        , skip <|
            test "four cards, one trick" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Four ]
                        [ Three, Five, Six ]
                        |> Expect.equal { status = Finished, cards = 4, tricks = 1 }
        , skip <|
            test "the ace reigns supreme" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ace ]
                        [ Three, Four, Five, Six, Seven ]
                        |> Expect.equal { status = Finished, cards = 7, tricks = 1 }
        , skip <|
            test "the king beats ace" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ace ]
                        [ Three, Four, Five, Six, King ]
                        |> Expect.equal { status = Finished, cards = 7, tricks = 1 }
        , skip <|
            test "the queen seduces the king" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ace, Seven, Eight, Queen ]
                        [ Three, Four, Five, Six, King ]
                        |> Expect.equal { status = Finished, cards = 10, tricks = 1 }
        , skip <|
            test "the jack betrays the queen" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ace, Seven, Eight, Queen ]
                        [ Three, Four, Five, Six, King, Nine, Jack ]
                        |> Expect.equal { status = Finished, cards = 12, tricks = 1 }
        , skip <|
            test "the 10 just wants to put on a show" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ace, Seven, Eight, Queen, Ten ]
                        [ Three, Four, Five, Six, King, Nine, Jack ]
                        |> Expect.equal { status = Finished, cards = 13, tricks = 1 }
        , skip <|
            test "simple loop with decks of 3 cards" <|
                \() ->
                    Camicia.simulateGame
                        [ Jack, Two, Three ]
                        [ Four, Jack, Five ]
                        |> Expect.equal { status = Loop, cards = 8, tricks = 3 }
        , skip <|
            test "the story is starting to get a bit complicated" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Six, Six, Jack, Four, King, Queen, Ten, King, Jack, Queen, Two, Three, King, Five, Six, Queen, Queen, Ace, Ace, Six, Nine, King, Ace, Eight, King, Two, Ace, Nine, Ace, Queen, Four, King, King, King, Three, Five, King, Eight, Queen, Three, Queen, Seven, Jack, King, Jack, Nine, Jack, Three, Three, King, King, Queen, Ace, King, Seven, Ten, Ace, Queen, Seven, Ten, Jack, Four, Five, Jack, Nine, Ten, Queen, Jack, Jack, King, Six, Ten, Jack, Six, Queen, Jack, Five, Jack, Queen, Queen, Eight, Three, Eight, Ace, Two, Six, Nine, King, Seven, Jack, King, King, Eight, King, Queen, Six, Ten, Jack, Ten, Jack, Queen, Jack, Ten, Three, Eight, King, Ace, Six, Nine, King, Two, Ace, Ace, Ten, Jack, Six, Ace, Four, Jack, Ace, Jack, Jack, Six, Two, Jack, Three, King, Two, Five, Nine, Jack, Nine, Six, King, Ace, Five, Queen, Jack, Two, Queen, King, Ace, Three, King, Jack, King, Two, Five, Six, Queen, Jack, Queen, Queen, Jack, Two, Jack, Nine, Queen, Seven, Seven, Ace, Queen, Seven, Queen, Jack, King, Jack, Ace, Seven, Seven, Eight, Queen, Ten, Jack, Ten, Jack, Jack, Nine, Two, Ace, Two ]
                        [ Seven, Two, Ten, King, Eight, Two, Jack, Nine, Ace, Five, Six, Jack, Queen, Six, King, Six, Five, Ace, Four, Queen, Seven, Jack, Seven, Ten, Two, Queen, Eight, Two, Two, King, Jack, Ace, Five, Five, Ace, Four, Queen, Six, Queen, King, Ten, Eight, Queen, Two, Ten, Jack, Ace, Queen, Eight, Queen, Queen, Jack, Jack, Ace, Ace, Nine, Ten, Jack, King, Four, Queen, Ten, Ten, Jack, King, Ten, Two, Jack, Seven, Ace, King, King, Jack, Ace, Jack, Ten, Eight, King, Ace, Seven, Queen, Queen, Jack, Three, Queen, Four, Ace, Three, Ace, Queen, Queen, Queen, Five, Four, King, Jack, Ten, Ace, Queen, Jack, Six, Jack, Ace, Ten, Ace, Five, Eight, Three, King, Five, Nine, Queen, Eight, Seven, Seven, Jack, Seven, Queen, Queen, Queen, Ace, Seven, Eight, Nine, Ace, Queen, Ace, King, Eight, Ace, Ace, Jack, Eight, Four, Eight, King, Jack, Ace, Ten, Queen, Eight, Jack, Eight, Six, Ten, Queen, Jack, Jack, Ace, Ace, Jack, Five, Queen, Six, Jack, King, Queen, Eight, King, Four, Queen, Queen, Six, Jack, King, Four, Seven, Jack, Jack, Nine, Nine, Ace, Queen, Queen, King, Ace, Six, Five, King ]
                        |> Expect.equal { status = Finished, cards = 361, tricks = 1 }
        , skip <|
            test "two tricks" <|
                \() ->
                    Camicia.simulateGame
                        [ Jack ]
                        [ Three, Jack ]
                        |> Expect.equal { status = Finished, cards = 5, tricks = 2 }
        , skip <|
            test "more tricks" <|
                \() ->
                    Camicia.simulateGame
                        [ Jack, Two, Four ]
                        [ Three, Jack, Ace ]
                        |> Expect.equal { status = Finished, cards = 12, tricks = 4 }
        , skip <|
            test "simple loop with decks of 4 cards" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Three, Jack, Six ]
                        [ King, Five, Jack, Seven ]
                        |> Expect.equal { status = Loop, cards = 16, tricks = 4 }
        , skip <|
            test "easy card combination" <|
                \() ->
                    Camicia.simulateGame
                        [ Four, Eight, Seven, Five, Four, Ten, Three, Nine, Seven, Three, Ten, Ten, Six, Eight, Two, Eight, Five, Four, Five, Nine, Six, Five, Two, Eight, Ten, Nine ]
                        [ Six, Nine, Four, Seven, Two, Two, Three, Six, Seven, Three, Ace, Ace, Ace, Ace, King, King, King, King, Queen, Queen, Queen, Queen, Jack, Jack, Jack, Jack ]
                        |> Expect.equal { status = Finished, cards = 40, tricks = 4 }
        , skip <|
            test "easy card combination, inverted decks" <|
                \() ->
                    Camicia.simulateGame
                        [ Three, Three, Five, Seven, Three, Two, Ten, Seven, Six, Seven, Ace, Ace, Ace, Ace, King, King, King, King, Queen, Queen, Queen, Queen, Jack, Jack, Jack, Jack ]
                        [ Five, Ten, Eight, Two, Six, Seven, Two, Four, Nine, Two, Six, Ten, Ten, Five, Four, Eight, Four, Eight, Six, Nine, Eight, Five, Nine, Three, Four, Nine ]
                        |> Expect.equal { status = Finished, cards = 40, tricks = 4 }
        , skip <|
            test "mirrored decks" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ace, Three, Ace, Three, King, Four, King, Two, Queen, Two, Queen, Ten, Jack, Five, Jack, Six, Ten, Two, Nine, Ten, Seven, Three, Nine, Six, Nine ]
                        [ Six, Ace, Four, Ace, Seven, King, Four, King, Seven, Queen, Seven, Queen, Five, Jack, Eight, Jack, Four, Five, Eight, Nine, Ten, Six, Eight, Three, Eight, Five ]
                        |> Expect.equal { status = Finished, cards = 59, tricks = 4 }
        , skip <|
            test "opposite decks" <|
                \() ->
                    Camicia.simulateGame
                        [ Four, Ace, Nine, Ace, Four, King, Nine, King, Six, Queen, Eight, Queen, Eight, Jack, Ten, Jack, Nine, Eight, Four, Six, Three, Six, Five, Two, Four, Three ]
                        [ Ten, Seven, Three, Two, Nine, Two, Seven, Eight, Seven, Five, Jack, Seven, Jack, Ten, Queen, Ten, Queen, Three, King, Five, King, Six, Ace, Two, Ace, Five ]
                        |> Expect.equal { status = Finished, cards = 151, tricks = 21 }
        , skip <|
            test "random decks #1" <|
                \() ->
                    Camicia.simulateGame
                        [ King, Ten, Nine, Eight, Jack, Eight, Six, Nine, Seven, Ace, King, Five, Four, Four, Jack, Five, Jack, Four, Three, Five, Eight, Six, Seven, Seven, Four, Nine ]
                        [ Six, Three, King, Ace, Queen, Ten, Ace, Two, Queen, Eight, Two, Ten, Ten, Two, Queen, Three, King, Nine, Seven, Ace, Three, Queen, Five, Jack, Two, Six ]
                        |> Expect.equal { status = Finished, cards = 542, tricks = 76 }
        , skip <|
            test "random decks #2" <|
                \() ->
                    Camicia.simulateGame
                        [ Eight, Ace, Four, Eight, Five, Queen, Jack, Two, Six, Two, Nine, Seven, King, Ace, Eight, Ten, King, Eight, Ten, Nine, King, Six, Seven, Three, King, Nine ]
                        [ Ten, Five, Two, Six, Queen, Jack, Ace, Nine, Five, Five, Three, Seven, Three, Jack, Ace, Two, Queen, Three, Jack, Queen, Four, Ten, Four, Seven, Four, Six ]
                        |> Expect.equal { status = Finished, cards = 327, tricks = 42 }
        , skip <|
            test "Kleber 1999" <|
                \() ->
                    Camicia.simulateGame
                        [ Four, Eight, Nine, Jack, Queen, Eight, Five, Five, King, Two, Ace, Nine, Eight, Five, Ten, Ace, Four, Jack, Three, King, Six, Nine, Two, Queen, King, Seven ]
                        [ Ten, Jack, Three, Two, Four, Ten, Four, Seven, Five, Three, Six, Six, Seven, Ace, Jack, Queen, Ace, Seven, Two, Ten, Three, King, Nine, Six, Eight, Queen ]
                        |> Expect.equal { status = Finished, cards = 5790, tricks = 805 }
        , skip <|
            test "Collins 2006" <|
                \() ->
                    Camicia.simulateGame
                        [ Ace, Eight, Queen, King, Nine, Ten, Three, Seven, Four, Two, Queen, Three, Two, Ten, Nine, King, Ace, Eight, Seven, Seven, Four, Five, Jack, Nine, Two, Ten ]
                        [ Four, Jack, Ace, King, Eight, Five, Six, Six, Ace, Six, Five, Queen, Four, Six, Ten, Eight, Jack, Two, Five, Seven, Queen, Jack, Three, Three, King, Nine ]
                        |> Expect.equal { status = Finished, cards = 6913, tricks = 960 }
        , skip <|
            test "Mann and Wu 2007" <|
                \() ->
                    Camicia.simulateGame
                        [ King, Two, King, King, Three, Three, Six, Ten, King, Six, Ace, Two, Five, Five, Seven, Nine, Jack, Ace, Ace, Three, Four, Queen, Four, Eight, Jack, Six ]
                        [ Four, Five, Two, Queen, Seven, Nine, Nine, Queen, Seven, Jack, Nine, Eight, Ten, Three, Ten, Jack, Four, Ten, Eight, Six, Eight, Seven, Ace, Queen, Five, Two ]
                        |> Expect.equal { status = Finished, cards = 7157, tricks = 1007 }
        , skip <|
            test "Nessler 2012" <|
                \() ->
                    Camicia.simulateGame
                        [ Ten, Three, Six, Seven, Queen, Two, Nine, Eight, Two, Eight, Four, Ace, Ten, Six, King, Two, Ten, Ace, Five, Ace, Two, Four, Queen, Jack, King, Four ]
                        [ Ten, Queen, Four, Six, Jack, Nine, Three, Jack, Nine, Three, Three, Queen, King, Five, Nine, Five, King, Six, Five, Seven, Eight, Jack, Ace, Seven, Eight, Seven ]
                        |> Expect.equal { status = Finished, cards = 7207, tricks = 1015 }
        , skip <|
            test "Anderson 2013" <|
                \() ->
                    Camicia.simulateGame
                        [ Six, Seven, Ace, Three, Queen, Three, Five, Jack, Three, Two, Jack, Seven, Four, Five, Queen, Ten, Five, Ace, Jack, Two, King, Eight, Nine, Nine, King, Three ]
                        [ Four, Jack, Six, Nine, Eight, Five, Ten, Seven, Nine, Queen, Two, Seven, Ten, Eight, Four, Ten, Ace, Six, Four, Ace, Six, Eight, Queen, King, King, Two ]
                        |> Expect.equal { status = Finished, cards = 7225, tricks = 1016 }
        , skip <|
            test "Rucklidge 2014" <|
                \() ->
                    Camicia.simulateGame
                        [ Eight, Jack, Two, Nine, Four, Four, Five, Eight, Queen, Three, Nine, Three, Six, Two, Eight, Ace, Ace, Ace, Nine, Four, Seven, Two, Five, Queen, Queen, Three ]
                        [ King, Seven, Ten, Six, Three, Jack, Ace, Seven, Six, Five, Five, Eight, Ten, Nine, Ten, Four, Two, Seven, King, Queen, Ten, King, Six, Jack, Jack, King ]
                        |> Expect.equal { status = Finished, cards = 7959, tricks = 1122 }
        , skip <|
            test "Nessler 2021" <|
                \() ->
                    Camicia.simulateGame
                        [ Seven, Two, Three, Four, King, Nine, Six, Ten, Ace, Eight, Nine, Queen, Seven, Ace, Four, Eight, Jack, Jack, Ace, Four, Three, Two, Five, Six, Six, Jack ]
                        [ Three, Ten, Eight, Nine, Eight, King, King, Two, Five, Five, Seven, Six, Four, Three, Five, Seven, Ace, Nine, Jack, King, Two, Queen, Ten, Queen, Ten, Queen ]
                        |> Expect.equal { status = Finished, cards = 7972, tricks = 1106 }
        , skip <|
            test "Nessler 2022" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Ten, Ten, Ace, Jack, Three, Eight, Queen, Two, Five, Five, Five, Nine, Two, Four, Three, Ten, Queen, Ace, King, Queen, Jack, Jack, Nine, Queen, King ]
                        [ Ten, Seven, Six, Three, Six, Ace, Eight, Nine, Four, Three, King, Jack, Six, King, Four, Nine, Seven, Eight, Five, Seven, Eight, Two, Ace, Seven, Four, Six ]
                        |> Expect.equal { status = Finished, cards = 8344, tricks = 1164 }
        , skip <|
            test "Casella 2024, first infinite game found" <|
                \() ->
                    Camicia.simulateGame
                        [ Two, Eight, Four, King, Five, Two, Three, Queen, Six, King, Queen, Ace, Jack, Three, Five, Nine, Eight, Three, Ace, Ace, Jack, Four, Four, Jack, Seven, Five ]
                        [ Seven, Seven, Eight, Six, Ten, Ten, Six, Ten, Seven, Two, Queen, Six, Three, Two, Four, King, Queen, Ten, Jack, Five, Nine, Eight, Nine, Nine, King, Ace ]
                        |> Expect.equal { status = Loop, cards = 474, tricks = 66 }
        ]
