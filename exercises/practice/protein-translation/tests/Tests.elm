module Tests exposing (tests)

import Expect
import ProteinTranslation exposing (Error(..))
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "ProteinTranslation"
        [ test "Empty RNA sequence results in no proteins" <|
            \() ->
                ProteinTranslation.proteins ""
                    |> Expect.equal (Ok [])
        , skip <|
            test "Methionine RNA sequence" <|
                \() ->
                    ProteinTranslation.proteins "AUG"
                        |> Expect.equal (Ok [ "Methionine" ])
        , skip <|
            test "Phenylalanine RNA sequence 1" <|
                \() ->
                    ProteinTranslation.proteins "UUU"
                        |> Expect.equal (Ok [ "Phenylalanine" ])
        , skip <|
            test "Phenylalanine RNA sequence 2" <|
                \() ->
                    ProteinTranslation.proteins "UUC"
                        |> Expect.equal (Ok [ "Phenylalanine" ])
        , skip <|
            test "Leucine RNA sequence 1" <|
                \() ->
                    ProteinTranslation.proteins "UUA"
                        |> Expect.equal (Ok [ "Leucine" ])
        , skip <|
            test "Leucine RNA sequence 2" <|
                \() ->
                    ProteinTranslation.proteins "UUG"
                        |> Expect.equal (Ok [ "Leucine" ])
        , skip <|
            test "Serine RNA sequence 1" <|
                \() ->
                    ProteinTranslation.proteins "UCU"
                        |> Expect.equal (Ok [ "Serine" ])
        , skip <|
            test "Serine RNA sequence 2" <|
                \() ->
                    ProteinTranslation.proteins "UCC"
                        |> Expect.equal (Ok [ "Serine" ])
        , skip <|
            test "Serine RNA sequence 3" <|
                \() ->
                    ProteinTranslation.proteins "UCA"
                        |> Expect.equal (Ok [ "Serine" ])
        , skip <|
            test "Serine RNA sequence 4" <|
                \() ->
                    ProteinTranslation.proteins "UCG"
                        |> Expect.equal (Ok [ "Serine" ])
        , skip <|
            test "Tyrosine RNA sequence 1" <|
                \() ->
                    ProteinTranslation.proteins "UAU"
                        |> Expect.equal (Ok [ "Tyrosine" ])
        , skip <|
            test "Tyrosine RNA sequence 2" <|
                \() ->
                    ProteinTranslation.proteins "UAC"
                        |> Expect.equal (Ok [ "Tyrosine" ])
        , skip <|
            test "Cysteine RNA sequence 1" <|
                \() ->
                    ProteinTranslation.proteins "UGU"
                        |> Expect.equal (Ok [ "Cysteine" ])
        , skip <|
            test "Cysteine RNA sequence 2" <|
                \() ->
                    ProteinTranslation.proteins "UGC"
                        |> Expect.equal (Ok [ "Cysteine" ])
        , skip <|
            test "Tryptophan RNA sequence" <|
                \() ->
                    ProteinTranslation.proteins "UGG"
                        |> Expect.equal (Ok [ "Tryptophan" ])
        , skip <|
            test "STOP codon RNA sequence 1" <|
                \() ->
                    ProteinTranslation.proteins "UAA"
                        |> Expect.equal (Ok [])
        , skip <|
            test "STOP codon RNA sequence 2" <|
                \() ->
                    ProteinTranslation.proteins "UAG"
                        |> Expect.equal (Ok [])
        , skip <|
            test "STOP codon RNA sequence 3" <|
                \() ->
                    ProteinTranslation.proteins "UGA"
                        |> Expect.equal (Ok [])
        , skip <|
            test "Sequence of two protein codons translates into proteins" <|
                \() ->
                    ProteinTranslation.proteins "UUUUUU"
                        |> Expect.equal (Ok [ "Phenylalanine", "Phenylalanine" ])
        , skip <|
            test "Sequence of two different protein codons translates into proteins" <|
                \() ->
                    ProteinTranslation.proteins "UUAUUG"
                        |> Expect.equal (Ok [ "Leucine", "Leucine" ])
        , skip <|
            test "Translate RNA strand into correct protein list" <|
                \() ->
                    ProteinTranslation.proteins "AUGUUUUGG"
                        |> Expect.equal (Ok [ "Methionine", "Phenylalanine", "Tryptophan" ])
        , skip <|
            test "Translation stops if STOP codon at beginning of sequence" <|
                \() ->
                    ProteinTranslation.proteins "UAGUGG"
                        |> Expect.equal (Ok [])
        , skip <|
            test "Translation stops if STOP codon at end of two-codon sequence" <|
                \() ->
                    ProteinTranslation.proteins "UGGUAG"
                        |> Expect.equal (Ok [ "Tryptophan" ])
        , skip <|
            test "Translation stops if STOP codon at end of three-codon sequence" <|
                \() ->
                    ProteinTranslation.proteins "AUGUUUUAA"
                        |> Expect.equal (Ok [ "Methionine", "Phenylalanine" ])
        , skip <|
            test "Translation stops if STOP codon in middle of three-codon sequence" <|
                \() ->
                    ProteinTranslation.proteins "UGGUAGUGG"
                        |> Expect.equal (Ok [ "Tryptophan" ])
        , skip <|
            test "Translation stops if STOP codon in middle of six-codon sequence" <|
                \() ->
                    ProteinTranslation.proteins "UGGUGUUAUUAAUGGUUU"
                        |> Expect.equal (Ok [ "Tryptophan", "Cysteine", "Tyrosine" ])
        , skip <|
            test "Unknown amino acids, not part of a codon, can't translate" <|
                \() ->
                    ProteinTranslation.proteins "XYZ"
                        |> Expect.equal (Err InvalidCodon)
        , skip <|
            test "Incomplete RNA sequence can't translate" <|
                \() ->
                    ProteinTranslation.proteins "AUGU"
                        |> Expect.equal (Err InvalidCodon)
        , skip <|
            test "Incomplete RNA sequence can translate if valid until a STOP codon" <|
                \() ->
                    ProteinTranslation.proteins "UUCUUCUAAUGGU"
                        |> Expect.equal (Ok [ "Phenylalanine", "Phenylalanine" ])
        , skip <|
            test "Sequence of two non-STOP codons does not translate to a STOP codon" <|
                \() ->
                    ProteinTranslation.proteins "AUGAUG"
                        |> Expect.equal (Ok [ "Methionine", "Methionine" ])
        ]
