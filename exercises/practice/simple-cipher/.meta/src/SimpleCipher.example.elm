module SimpleCipher exposing (decode, encode, keyGen)

import Random exposing (Generator)


type Direction
    = Encode
    | Decode


encode : String -> String -> String
encode =
    transform Encode


decode : String -> String -> String
decode =
    transform Decode


transform : Direction -> String -> String -> String
transform direction key text =
    let
        longKey =
            case String.length text // String.length key of
                0 ->
                    key

                n ->
                    String.repeat (1 + n) key

        toInt char =
            Char.toCode char - Char.toCode 'a'

        toChar int =
            Char.fromCode (int + Char.toCode 'a')

        combine a b =
            case direction of
                Encode ->
                    modBy 26 (toInt a + toInt b) |> toChar

                Decode ->
                    modBy 26 (toInt a - toInt b) |> toChar
    in
    List.map2 combine (String.toList text) (String.toList longKey)
        |> String.fromList


keyGen : Generator String
keyGen =
    let
        charGen =
            Random.int (Char.toCode 'a') (Char.toCode 'z')
                |> Random.map Char.fromCode
    in
    Random.list 100 charGen
        |> Random.map String.fromList
