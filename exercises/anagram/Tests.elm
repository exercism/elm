port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
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
        , test "detects simple anagram" <|
            \() ->
                Expect.equal [ "tan" ]
                    (detect "ant" [ "tan", "stand", "at" ])
        , test "does not detect false positives" <|
            \() ->
                Expect.equal []
                    (detect "galea" [ "eagle" ])
        , test "detects multiple anagrams" <|
            \() ->
                Expect.equal [ "stream", "maters" ]
                    (detect "master" [ "stream", "pigeon", "maters" ])
        , test "does not detect anagram subsets" <|
            \() ->
                Expect.equal []
                    (detect "good" [ "dog", "goody" ])
        , test "detects anagram" <|
            \() ->
                Expect.equal [ "inlets" ]
                    (detect "listen" [ "enlists", "google", "inlets", "banana" ])
        , test "detects multiple anagrams" <|
            \() ->
                Expect.equal [ "gallery", "regally", "largely" ]
                    (detect "allergy" [ "gallery", "ballerina", "regally", "clergy", "largely", "leading" ])
        , test "does not detect indentical words" <|
            \() ->
                Expect.equal [ "cron" ]
                    (detect "corn" [ "corn", "dark", "Corn", "rank", "CORN", "cron", "park" ])
        , test "does not detect non-anagrams with identical checksum" <|
            \() ->
                Expect.equal []
                    (detect "mass" [ "last" ])
        , test "detects anagrams case-insensitively" <|
            \() ->
                Expect.equal [ "Carthorse" ]
                    (detect "Orchestra" [ "cashregister", "Carthorse", "radishes" ])
        , test "detects anagrams using case-insensitive subject" <|
            \() ->
                Expect.equal [ "carthorse" ]
                    (detect "Orchestra" [ "cashregister", "carthorse", "radishes" ])
        , test "detects anagrams using case-insensitve possible matches" <|
            \() ->
                Expect.equal [ "Carthorse" ]
                    (detect "orchestra" [ "cashregister", "Carthorse", "radishes" ])
        , test "does not detect a word as its own anagram" <|
            \() ->
                Expect.equal []
                    (detect "banana" [ "Banana" ])
        , test "does not detect a anagram if the original word is repeated" <|
            \() ->
                Expect.equal []
                    (detect "go" [ "go Go GO" ])
        , test "anagrams must use all letters exactly once" <|
            \() ->
                Expect.equal []
                    (detect "tapper" [ "patter" ])
        , test "eliminates anagrams with the same checksum" <|
            \() ->
                Expect.equal []
                    (detect "mass" [ "last" ])
        , test "detects unicode anagrams" <|
            \() ->
                Expect.equal [ "ΒΓΑ", "γβα" ]
                    (detect "ΑΒΓ" [ "ΒΓΑ", "ΒΓΔ", "γβα" ])
        , test "eliminates misleading unicode anagrams" <|
            \() ->
                Expect.equal []
                    (detect "ΑΒΓ" [ "ABΓ" ])
        , test "capital word is not own anagram" <|
            \() ->
                Expect.equal []
                    (detect "BANANA" [ "Banana" ])
        , test "anagrams must use all letters exactly once" <|
            \() ->
                Expect.equal []
                    (detect "patter" [ "tapper" ])
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
