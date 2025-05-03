module SquareRoot exposing (squareRoot)


squareRoot : Int -> Int
squareRoot radicand =
    case radicand of
        1 ->
            1

        _ ->
            let
                improveGuess : Float -> Float
                improveGuess guess =
                    let
                        nextGuess =
                            (guess + toFloat radicand / guess) / 2
                    in
                    if abs (guess - nextGuess) < 0.0001 then
                        nextGuess

                    else
                        improveGuess nextGuess

                initialGuess =
                    toFloat radicand / 2
            in
            initialGuess
                |> improveGuess
                |> round
