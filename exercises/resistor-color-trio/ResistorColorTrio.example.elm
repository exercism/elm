module ResistorColorTrio exposing (colorsToOhms)

import List


resistorValues : List ( String, Int )
resistorValues =
    [ ( "black", 0 )
    , ( "brown", 1 )
    , ( "red", 2 )
    , ( "orange", 3 )
    , ( "yellow", 4 )
    , ( "green", 5 )
    , ( "blue", 6 )
    , ( "violet", 7 )
    , ( "grey", 8 )
    , ( "white", 9 )
    ]


colorToValue : String -> Maybe Int
colorToValue color =
    List.filter (Tuple.first >> (==) (String.toLower color)) resistorValues
        |> List.map Tuple.second
        |> List.head


colorsToOhms : ( String, String, String ) -> Result String String
colorsToOhms ( a, b, c ) =
    case ( colorToValue a, colorToValue b, colorToValue c ) of
        ( Just valA, Just valB, Just valC ) ->
            (valA * 10 + valB)
                * (10 ^ valC)
                |> (\value ->
                        if value > 1000 then
                            String.fromInt (value // 1000) ++ " kiloohms"

                        else
                            String.fromInt value ++ " ohms"
                   )
                |> Ok

        _ ->
            Err "one of the color didn't match"
