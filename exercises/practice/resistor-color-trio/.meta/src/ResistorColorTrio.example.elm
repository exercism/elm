module ResistorColorTrio exposing (Color(..), label)


type Color
    = Black
    | Brown
    | Red
    | Orange
    | Yellow
    | Green
    | Blue
    | Violet
    | Grey
    | White


label : List Color -> String
label colors =
    let
        ( magnitude, unit ) =
            colors |> totalResistance |> formatted
    in
    String.fromInt magnitude ++ " " ++ unit


formatted : Int -> ( Int, String )
formatted resistance =
    if resistance < 1000 then
        ( resistance, "ohms" )

    else if resistance < 1000000 then
        ( resistance // 1000, "kiloohms" )

    else if resistance < 1000000000 then
        ( resistance // 1000000, "megaohms" )

    else
        ( resistance // 1000000000, "gigaohms" )


totalResistance : List Color -> Int
totalResistance colors =
    case colors of
        first :: second :: third :: _ ->
            (bandValue first * 10 + bandValue second) * 10 ^ bandValue third

        first :: second :: [] ->
            bandValue first * 10 + bandValue second

        first :: [] ->
            bandValue first

        _ ->
            -1


bandValue : Color -> Int
bandValue color =
    case color of
        Black ->
            0

        Brown ->
            1

        Red ->
            2

        Orange ->
            3

        Yellow ->
            4

        Green ->
            5

        Blue ->
            6

        Violet ->
            7

        Grey ->
            8

        White ->
            9
