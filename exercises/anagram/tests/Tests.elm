module Tests exposing (..)

import Test exposing (..)
import Expect
import Anagram exposing (detect)


tests : Test
tests =
    describe "Anagram"
        [ test "no matches" <|
            \() ->
                Expect.equal []
                    (detect "diaper" [ "hello", "world", "zombies", "pants" ])
        , skip <|
            test "detects simple anagram" <|
                \() ->
                    Expect.equal [ "tan" ]
                        (detect "ant" [ "tan", "stand", "at" ])
        , skip <|
            test "does not detect false positives" <|
                \() ->
                    Expect.equal []
                        (detect "galea" [ "eagle" ])
        , skip <|
            test "detects multiple anagrams" <|
                \() ->
                    Expect.equal [ "stream", "maters" ]
                        (detect "master" [ "stream", "pigeon", "maters" ])
        , skip <|
            test "does not detect anagram subsets" <|
                \() ->
                    Expect.equal []
                        (detect "good" [ "dog", "goody" ])
        , skip <|
            test "detects anagram" <|
                \() ->
                    Expect.equal [ "inlets" ]
                        (detect "listen" [ "enlists", "google", "inlets", "banana" ])
        , skip <|
            test "detects even more anagrams" <|
                \() ->
                    Expect.equal [ "gallery", "regally", "largely" ]
                        (detect "allergy" [ "gallery", "ballerina", "regally", "clergy", "largely", "leading" ])
        , skip <|
            test "does not detect indentical words" <|
                \() ->
                    Expect.equal [ "cron" ]
                        (detect "corn" [ "corn", "dark", "Corn", "rank", "CORN", "cron", "park" ])
        , skip <|
            test "does not detect non-anagrams with identical checksum" <|
                \() ->
                    Expect.equal []
                        (detect "mass" [ "last" ])
        , skip <|
            test "detects anagrams case-insensitively" <|
                \() ->
                    Expect.equal [ "Carthorse" ]
                        (detect "Orchestra" [ "cashregister", "Carthorse", "radishes" ])
        , skip <|
            test "detects anagrams using case-insensitive subject" <|
                \() ->
                    Expect.equal [ "carthorse" ]
                        (detect "Orchestra" [ "cashregister", "carthorse", "radishes" ])
        , skip <|
            test "detects anagrams using case-insensitve possible matches" <|
                \() ->
                    Expect.equal [ "Carthorse" ]
                        (detect "orchestra" [ "cashregister", "Carthorse", "radishes" ])
        , skip <|
            test "does not detect a word as its own anagram" <|
                \() ->
                    Expect.equal []
                        (detect "banana" [ "Banana" ])
        , skip <|
            test "does not detect a anagram if the original word is repeated" <|
                \() ->
                    Expect.equal []
                        (detect "go" [ "go Go GO" ])
        , skip <|
            test "anagrams must use all letters exactly once (go)" <|
                \() ->
                    Expect.equal []
                        (detect "tapper" [ "patter" ])
        , skip <|
            test "eliminates anagrams with the same checksum" <|
                \() ->
                    Expect.equal []
                        (detect "mass" [ "last" ])
        , skip <|
            test "detects unicode anagrams" <|
                \() ->
                    Expect.equal [ "ΒΓΑ", "γβα" ]
                        (detect "ΑΒΓ" [ "ΒΓΑ", "ΒΓΔ", "γβα" ])
        , skip <|
            test "eliminates misleading unicode anagrams" <|
                \() ->
                    Expect.equal []
                        (detect "ΑΒΓ" [ "ABΓ" ])
        , skip <|
            test "capital word is not own anagram" <|
                \() ->
                    Expect.equal []
                        (detect "BANANA" [ "Banana" ])
        , skip <|
            test "anagrams must use all letters exactly once (banana)" <|
                \() ->
                    Expect.equal []
                        (detect "patter" [ "tapper" ])
        ]
