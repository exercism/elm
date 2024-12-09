module Tests exposing (tests)

import Expect
import KindergartenGarden exposing (Plant(..), Student(..))
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "KindergartenGarden"
        [ describe "partial garden"
            [ -- skip <|
              test "garden with single student" <|
                \() ->
                    KindergartenGarden.plants "RC\nGG" Alice
                        |> Expect.equal [ Radish, Clover, Grass, Grass ]
            , skip <|
                test "different garden with single student" <|
                    \() ->
                        KindergartenGarden.plants "VC\nRC" Alice
                            |> Expect.equal [ Violet, Clover, Radish, Clover ]
            , skip <|
                test "garden with two students" <|
                    \() ->
                        KindergartenGarden.plants "VVCG\nVVRC" Bob
                            |> Expect.equal [ Clover, Grass, Radish, Clover ]
            , describe "multiple students for the same garden with three students"
                [ skip <|
                    test "second student's garden" <|
                        \() ->
                            KindergartenGarden.plants "VVCCGG\nVVCCGG" Bob
                                |> Expect.equal [ Clover, Clover, Clover, Clover ]
                , skip <|
                    test "third student's garden" <|
                        \() ->
                            KindergartenGarden.plants "VVCCGG\nVVCCGG" Charlie
                                |> Expect.equal [ Grass, Grass, Grass, Grass ]
                ]
            ]
        , describe "full garden"
            [ skip <|
                test "for Alice, first student's garden" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Alice
                            |> Expect.equal [ Violet, Radish, Violet, Radish ]
            , skip <|
                test "for Bob, second student's garden" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Bob
                            |> Expect.equal [ Clover, Grass, Clover, Clover ]
            , skip <|
                test "for Charlie" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Charlie
                            |> Expect.equal [ Violet, Violet, Clover, Grass ]
            , skip <|
                test "for David" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" David
                            |> Expect.equal [ Radish, Violet, Clover, Radish ]
            , skip <|
                test "for Eve" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Eve
                            |> Expect.equal [ Clover, Grass, Radish, Grass ]
            , skip <|
                test "for Fred" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Fred
                            |> Expect.equal [ Grass, Clover, Violet, Clover ]
            , skip <|
                test "for Ginny" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Ginny
                            |> Expect.equal [ Clover, Grass, Grass, Clover ]
            , skip <|
                test "for Harriet" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Harriet
                            |> Expect.equal [ Violet, Radish, Radish, Violet ]
            , skip <|
                test "for Ileana" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Ileana
                            |> Expect.equal [ Grass, Clover, Violet, Clover ]
            , skip <|
                test "for Joseph" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Joseph
                            |> Expect.equal [ Violet, Clover, Violet, Grass ]
            , skip <|
                test "for Kincaid, second to last student's garden" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Kincaid
                            |> Expect.equal [ Grass, Clover, Clover, Grass ]
            , skip <|
                test "for Larry, last student's garden" <|
                    \() ->
                        KindergartenGarden.plants "VRCGVVRVCGGCCGVRGCVCGCGV\nVRCCCGCRRGVCGCRVVCVGCGCV" Larry
                            |> Expect.equal [ Grass, Violet, Clover, Violet ]
            ]
        ]
