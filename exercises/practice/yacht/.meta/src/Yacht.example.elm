module Yacht exposing (Category(..), score)

import Dict


type Category
    = Ones
    | Twos
    | Threes
    | Fours
    | Fives
    | Sixes
    | FullHouse
    | FourOfAKind
    | LittleStraight
    | BigStraight
    | Choice
    | Yacht


score : List Int -> Category -> Int
score dice category =
    case ( category, countDice dice ) of
        ( Ones, _ ) ->
            countDice 1 dice

        ( Twos, _ ) ->
            2 * countDice 2 dice

        ( Threes, _ ) ->
            3 * countDice 3 dice

        ( Fours, _ ) ->
            4 * countDice 4 dice

        ( Fives, _ ) ->
            5 * countDice 5 dice

        ( Sixes, _ ) ->
            6 * countDice 6 dice

        ( FullHouse, [ ( two, 2 ), ( three, 3 ) ] ) ->
            3 * three + 2 * two

        ( FourOfAKind, [ _, ( four, 4 ) ] ) ->
            4 * four

        ( FourOfAKind, [ ( five, 5 ) ] ) ->
            4 * five

        ( LittleStraight, [ _, _, _, _, ( 5, 1 ) ] ) ->
            30

        ( BigStraight, [ ( 2, 1 ), _, _, _, _ ] ) ->
            30

        ( Choice, _ ) ->
            List.sum dice

        ( Yacht, [ _ ] ) ->
            50

        _ ->
            0


countDice : Int -> List Int -> Int
countDice number =
    List.filter ((==) number) >> List.length
countDice : List Int -> List ( Int, Int )
countDice diceList =
    let
        count currentCount =
            case currentCount of
                Nothing ->
                    Just 1

                Just n ->
                    Just (n + 1)
    in
    diceList
        |> List.foldr (\dice -> Dict.update dice count) Dict.empty
        |> Dict.toList
        |> List.sortBy Tuple.second
