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
        raw =
            colors |> rawValue |> toFloat

        ( value, unit ) =
            if raw >= 1.0e9 then
                ( raw / 1.0e9, "gigaohms" )

            else if raw >= 1.0e6 then
                ( raw / 1.0e6, "megaohms" )

            else if raw >= 1.0e3 then
                ( raw / 1.0e3, "kiloohms" )

            else
                ( raw, "ohms" )
    in
    String.fromInt (round value) ++ " " ++ unit


rawValue : List Color -> Int
rawValue colors =
    case colors of
        first :: second :: third :: _ ->
            (colorCode first * 10 + colorCode second) * 10 ^ colorCode third

        first :: second :: [] ->
            colorCode first * 10 + colorCode second

        _ ->
            -1


colorCode : Color -> Int
colorCode color =
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
