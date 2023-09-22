module Beers exposing (beerSongFrom)


beerSongFrom : Int -> String
beerSongFrom n =
    let
        songFrom nBeer =
            case nBeer of
                0 ->
                    if n > 30 then
                        "No more bottles of beer on the wall, no more bottles of beer.\n"
                            ++ "We've taken them down and passed them around; "
                            ++ "now we're all drunk and passed out!"

                    else
                        "No more bottles of beer on the wall, no more bottles of beer.\n"
                            ++ "Go to shore to get some more, 99 bottles of beer on the wall!"

                1 ->
                    "1 bottle of beer on the wall, 1 bottle of beer.\n"
                        ++ "Take it down and pass it around, no more bottles of beer on the wall.\n"
                        |> next nBeer

                2 ->
                    "2 bottles of beer on the wall, 2 bottles of beer.\n"
                        ++ "Take one down and pass it around, 1 bottle of beer on the wall.\n"
                        |> next nBeer

                _ ->
                    "{X} bottles of beer on the wall, {X} bottles of beer.\n"
                        ++ "Take one down and pass it around, {X-1} bottles of beer on the wall.\n"
                        |> String.replace "{X}" (String.fromInt nBeer)
                        |> String.replace "{X-1}" (String.fromInt (nBeer - 1))
                        |> next nBeer

        next nBeer songSoFar =
            songSoFar ++ "\n" ++ songFrom (nBeer - 1)
    in
    songFrom n
