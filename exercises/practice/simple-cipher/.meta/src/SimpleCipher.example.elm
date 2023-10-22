module SimpleCipher exposing (decode, encode, keyGen)

import Random exposing (Generator)


encode : String -> String -> String
encode =
    transformWith (+)


decode : String -> String -> String
decode =
    transformWith (-)


transformWith : (Int -> Int -> Int) -> String -> String -> String
transformWith operation key text =
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
            operation (toInt a) (toInt b) |> modBy 26 |> toChar
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
