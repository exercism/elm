module ProteinTranslation exposing (Error(..), proteins)


type Error
    = InvalidCodon


proteins : String -> Result Error (List String)
proteins strand =
    strand
        |> splitIntoCodons
        |> processCodons []
        |> Result.map List.reverse


splitIntoCodons : String -> List String
splitIntoCodons strand =
    if String.length strand > 3 then
        String.left 3 strand :: splitIntoCodons (String.dropLeft 3 strand)

    else
        [ strand ]


processCodons : List String -> List String -> Result Error (List String)
processCodons acc codons =
    case codons of
        [] ->
            Ok acc

        [ "" ] ->
            Ok acc

        codon :: rest ->
            case codonToProtein codon of
                Ok "STOP" ->
                    Ok acc

                Ok protein ->
                    processCodons (protein :: acc) rest

                Err err ->
                    Err err


codonToProtein : String -> Result Error String
codonToProtein codon =
    case codon of
        "AUG" ->
            Ok "Methionine"

        "UUU" ->
            Ok "Phenylalanine"

        "UUC" ->
            Ok "Phenylalanine"

        "UUA" ->
            Ok "Leucine"

        "UUG" ->
            Ok "Leucine"

        "UCU" ->
            Ok "Serine"

        "UCC" ->
            Ok "Serine"

        "UCA" ->
            Ok "Serine"

        "UCG" ->
            Ok "Serine"

        "UAU" ->
            Ok "Tyrosine"

        "UAC" ->
            Ok "Tyrosine"

        "UGU" ->
            Ok "Cysteine"

        "UGC" ->
            Ok "Cysteine"

        "UGG" ->
            Ok "Tryptophan"

        "UAA" ->
            Ok "STOP"

        "UAG" ->
            Ok "STOP"

        "UGA" ->
            Ok "STOP"

        _ ->
            Err InvalidCodon
