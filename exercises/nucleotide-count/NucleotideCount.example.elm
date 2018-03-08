module NucleotideCount exposing (nucleotideCounts, version)

import String


version : Int
version =
    2


type alias NucleotideCounts =
    { a : Int
    , t : Int
    , c : Int
    , g : Int
    }


init : NucleotideCounts
init =
    { a = 0
    , t = 0
    , c = 0
    , g = 0
    }


update : Char -> NucleotideCounts -> NucleotideCounts
update char counts =
    case char of
        'A' ->
            { counts | a = counts.a + 1 }

        'T' ->
            { counts | t = counts.t + 1 }

        'C' ->
            { counts | c = counts.c + 1 }

        'G' ->
            { counts | g = counts.g + 1 }

        _ ->
            counts


nucleotideCounts : String -> NucleotideCounts
nucleotideCounts sequence =
    String.foldl update init sequence
