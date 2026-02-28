module Camicia exposing (Card(..), Status(..), simulateGame)

import Set exposing (Set)


type Card
    = Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King


type Status
    = Finished
    | Loop


type Turn
    = PlayerA
    | PlayerAWithPenalty Int
    | PlayerB
    | PlayerBWithPenalty Int


type alias Game =
    { status : Status
    , cards : Int
    , tricks : Int

    -- (Int, Int) is (payment value, count), I would prefer a type but Set needs something comparable
    , history : Set ( List ( Int, Int ), List ( Int, Int ) )
    , playerA : List Card
    , playerB : List Card
    , pile : List Card
    , turn : Turn
    }


simulateGame : List Card -> List Card -> { status : Status, cards : Int, tricks : Int }
simulateGame playerA playerB =
    let
        initialGame =
            Game Loop 0 0 Set.empty playerA playerB [] PlayerA

        finalGame =
            gameLoop initialGame
    in
    { status = finalGame.status, cards = finalGame.cards, tricks = finalGame.tricks }


paymentValue : Card -> Int
paymentValue card =
    case card of
        Jack ->
            1

        Queen ->
            2

        King ->
            3

        Ace ->
            4

        _ ->
            0


gameSnapshot : Game -> ( List ( Int, Int ), List ( Int, Int ) )
gameSnapshot { playerA, playerB } =
    let
        contract =
            List.foldl countCards []

        countCards card count =
            case ( paymentValue card, count ) of
                ( value, [] ) ->
                    [ ( value, 1 ) ]

                ( value, ( lastValue, n ) :: rest ) ->
                    if value == lastValue then
                        ( lastValue, n + 1 ) :: rest

                    else
                        ( value, 1 ) :: count
    in
    ( contract playerA, contract playerB )


gameLoop : Game -> Game
gameLoop ({ playerA, playerB, cards, tricks, history, turn, pile } as currentGame) =
    let
        snapshot =
            gameSnapshot currentGame

        game =
            if List.isEmpty pile then
                { currentGame | history = Set.insert snapshot history }

            else
                currentGame
    in
    if List.isEmpty pile && Set.member snapshot history then
        game

    else
        case ( turn, playerA, playerB ) of
            ( PlayerA, card :: rest, _ ) ->
                gameLoop
                    { game
                        | turn =
                            if paymentValue card > 0 then
                                PlayerBWithPenalty (paymentValue card)

                            else
                                PlayerB
                        , playerA = rest
                        , pile = card :: pile
                        , cards = cards + 1
                    }

            ( PlayerAWithPenalty 0, _ :: _, _ ) ->
                gameLoop { game | turn = PlayerB, pile = [], playerB = playerB ++ List.reverse pile, tricks = tricks + 1 }

            ( PlayerAWithPenalty penalty, card :: rest, _ ) ->
                gameLoop
                    { game
                        | turn =
                            if paymentValue card > 0 then
                                PlayerBWithPenalty (paymentValue card)

                            else
                                PlayerAWithPenalty (penalty - 1)
                        , playerA = rest
                        , pile = card :: pile
                        , cards = cards + 1
                    }

            ( PlayerB, _, card :: rest ) ->
                gameLoop
                    { game
                        | turn =
                            if paymentValue card > 0 then
                                PlayerAWithPenalty (paymentValue card)

                            else
                                PlayerA
                        , playerB = rest
                        , pile = card :: pile
                        , cards = cards + 1
                    }

            ( PlayerBWithPenalty 0, _, _ :: _ ) ->
                gameLoop { game | turn = PlayerA, pile = [], playerA = playerA ++ List.reverse pile, tricks = tricks + 1 }

            ( PlayerBWithPenalty penalty, _, card :: rest ) ->
                gameLoop
                    { game
                        | turn =
                            if paymentValue card > 0 then
                                PlayerAWithPenalty (paymentValue card)

                            else
                                PlayerBWithPenalty (penalty - 1)
                        , playerB = rest
                        , pile = card :: pile
                        , cards = cards + 1
                    }

            _ ->
                { game | status = Finished, tricks = tricks + 1 }
