module NucleotideCount exposing (nucleotideCounts)

import String


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


update : Char -> NucleotideCounts -> Result String NucleotideCounts
update char counts =
    case char of
        'A' ->
            Ok { counts | a = counts.a + 1 }

        'T' ->
            Ok { counts | t = counts.t + 1 }

        'C' ->
            Ok { counts | c = counts.c + 1 }

        'G' ->
            Ok { counts | g = counts.g + 1 }

        _ ->
            Err "Invalid nucleotide in strand"


nucleotideCounts : String -> Result String NucleotideCounts
nucleotideCounts sequence =
    let
        propagateErrorOrUpdate =
            Result.andThen << update

        init =
            Ok
                { a = 0
                , t = 0
                , c = 0
                , g = 0
                }
    in
    String.foldl propagateErrorOrUpdate init sequence
