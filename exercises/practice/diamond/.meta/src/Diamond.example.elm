module Diamond exposing (rows)

import Char


rows : Char -> String
rows letter =
    let
        side =
            Char.toCode letter - aCode

        lines =
            List.range 0 side
                |> List.map
                    (\i ->
                        String.repeat (2 * i - 1) "_"
                            |> String.pad (2 * i + 1) (Char.fromCode (aCode + i))
                            |> String.pad (2 * side + 1) '_'
                    )
    in
    (lines ++ (lines |> List.reverse |> List.drop 1))
        |> String.join "\n"


aCode : Int
aCode =
    Char.toCode 'A'
