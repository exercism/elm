module RNATranscription exposing (toRNA)

import String


toRNA : String -> Result String String
toRNA dna =
    dna
        |> String.toList
        |> List.map toRNANucleotide
        |> resultExtraCombine
        |> Result.map (List.map String.fromChar)
        |> Result.map (String.join "")



-- Copied from elm-result-extra


resultExtraCombine : List (Result x a) -> Result x (List a)
resultExtraCombine =
    List.foldr (Result.map2 (::)) (Ok [])


toRNANucleotide : Char -> Result String Char
toRNANucleotide nuc =
    case nuc of
        'C' ->
            Ok 'G'

        'G' ->
            Ok 'C'

        'A' ->
            Ok 'U'

        'T' ->
            Ok 'A'

        _ ->
            Err (toString nuc ++ " is not a valid nucleotide")
