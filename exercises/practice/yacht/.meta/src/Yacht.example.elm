module Yacht exposing (Category(..), score)


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


type alias DiceGroup =
    { dice : Int
    , count : Int
    }


score : List Int -> Category -> Int
score dice category =
    case ( category, groupDice dice ) of
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

        ( FullHouse, [ three, two ] ) ->
            if three.count == 3 && two.count == 2 then
                3 * three.dice + 2 * two.dice

            else
                0

        ( FourOfAKind, [ four, _ ] ) ->
            if four.count == 4 then
                4 * four.dice

            else
                0

        ( FourOfAKind, [ five ] ) ->
            4 * five.dice

        ( LittleStraight, [ largest, _, _, _, _ ] ) ->
            if largest.dice == 5 then
                30

            else
                0

        ( BigStraight, [ _, _, _, _, smallest ] ) ->
            if smallest.dice == 2 then
                30

            else
                0

        ( Choice, _ ) ->
            List.sum dice

        ( Yacht, [ _ ] ) ->
            50

        _ ->
            0


countDice : Int -> List Int -> Int
countDice number =
    List.filter ((==) number) >> List.length


groupDice : List Int -> List DiceGroup
groupDice diceList =
    let
        groupByValue numbers groups =
            case ( numbers, groups ) of
                ( [], _ ) ->
                    groups

                ( number :: rest, [] ) ->
                    groupByValue rest [ { dice = number, count = 1 } ]

                ( number :: rest, ({ dice, count } as group) :: otherGroups ) ->
                    if number == dice then
                        groupByValue rest ({ group | count = count + 1 } :: otherGroups)

                    else
                        groupByValue rest ({ dice = number, count = 1 } :: groups)
    in
    groupByValue (List.sort diceList) []
        -- important for straights: groups with equal count are ordered in descending dice value
        |> List.sortBy (.count >> negate)
