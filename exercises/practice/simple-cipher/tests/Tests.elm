module Tests exposing (tests)

import Expect
import Fuzz exposing (Fuzzer)
import SimpleCipher
import Test exposing (Test, describe, fuzz, fuzz2, skip, test)


messageFuzzer : Fuzzer String
messageFuzzer =
    Fuzz.intRange (Char.toCode 'a') (Char.toCode 'z')
        |> Fuzz.map Char.fromCode
        |> Fuzz.list
        |> Fuzz.map String.fromList


keyFuzzer : Fuzzer String
keyFuzzer =
    Fuzz.intRange (Char.toCode 'a') (Char.toCode 'z')
        |> Fuzz.map Char.fromCode
        |> Fuzz.listOfLengthBetween 1 100
        |> Fuzz.map String.fromList


tests : Test
tests =
    describe "SimpleCipher"
        [ describe "Substitution cipher"
            [ -- skip <|
              test "Can encode" <|
                \() ->
                    SimpleCipher.encode "abcdefghij" "aaaaaaaaaa"
                        |> Expect.equal "abcdefghij"
            , skip <|
                test "Can decode" <|
                    \() ->
                        SimpleCipher.decode "abcdefghij" "abcdefghij"
                            |> Expect.equal "aaaaaaaaaa"
            , skip <|
                fuzz2 messageFuzzer keyFuzzer "encoding then decoding gives the original message" <|
                    \message key ->
                        message
                            |> SimpleCipher.encode key
                            |> SimpleCipher.decode key
                            |> Expect.equal message
            , skip <|
                fuzz2 messageFuzzer keyFuzzer "decoding then encoding gives the original message" <|
                    \message key ->
                        message
                            |> SimpleCipher.decode key
                            |> SimpleCipher.encode key
                            |> Expect.equal message
            , skip <|
                test "Can double shift encode" <|
                    \() ->
                        SimpleCipher.encode "iamapandabear" "iamapandabear"
                            |> Expect.equal "qayaeaagaciai"
            , skip <|
                test "Can wrap on encode" <|
                    \() ->
                        SimpleCipher.encode "abcdefghij" "zzzzzzzzzz"
                            |> Expect.equal "zabcdefghi"
            , skip <|
                test "Can wrap on decode" <|
                    \() ->
                        SimpleCipher.decode "abcdefghij" "zabcdefghi"
                            |> Expect.equal "zzzzzzzzzz"
            , skip <|
                test "Can encode messages longer than the key" <|
                    \() ->
                        SimpleCipher.encode "abc" "iamapandabear"
                            |> Expect.equal "iboaqcnecbfcr"
            , skip <|
                test "Can decode messages longer than the key" <|
                    \() ->
                        SimpleCipher.decode "abc" "iboaqcnecbfcr"
                            |> Expect.equal "iamapandabear"
            ]
        , describe "Random key cipher"
            [ skip <|
                fuzz (Fuzz.fromGenerator SimpleCipher.keyGen) "Can encode with a random key" <|
                    \key ->
                        SimpleCipher.encode key "aaaaaaaaaa"
                            |> Expect.equal (String.slice 0 10 key)
            , skip <|
                fuzz (Fuzz.fromGenerator SimpleCipher.keyGen) "Can decode with a random key" <|
                    \key ->
                        SimpleCipher.decode key (String.slice 0 10 key)
                            |> Expect.equal "aaaaaaaaaa"
            , skip <|
                fuzz2 messageFuzzer
                    (Fuzz.fromGenerator SimpleCipher.keyGen)
                    "encoding then decoding with a random key gives the original message"
                <|
                    \message key ->
                        message
                            |> SimpleCipher.encode key
                            |> SimpleCipher.decode key
                            |> Expect.equal message
            , skip <|
                fuzz2 messageFuzzer
                    (Fuzz.fromGenerator SimpleCipher.keyGen)
                    "decoding then encoding with a random key gives the original message"
                <|
                    \message key ->
                        message
                            |> SimpleCipher.decode key
                            |> SimpleCipher.encode key
                            |> Expect.equal message
            , skip <|
                fuzz (Fuzz.fromGenerator SimpleCipher.keyGen) "Key is made only of lowercase letters" <|
                    \key ->
                        key
                            |> String.all (\char -> 'a' <= char && char <= 'z')
                            |> Expect.equal True
            , skip <|
                fuzz (Fuzz.fromGenerator SimpleCipher.keyGen) "Key is 100 characters long" <|
                    \key ->
                        String.length key
                            |> Expect.equal 100
            ]
        ]
