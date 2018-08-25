module Tests exposing (anyCharacter, character, gibberish, gibberishQuestion, listOfCharacters, tests, uppercaseCharacter, uppercaseGibberish)

import Bob
import Char
import Expect
import Random
import String
import Test exposing (..)


tests : Test
tests =
    describe "Bob"
        [ test "stating something" <|
            \() ->
                Expect.equal "Whatever."
                    (Bob.hey "Tom-ay-to, tom-aaaah-to.")
        , skip <|
            test "shouting" <|
                \() ->
                    Expect.equal
                        "Whoa, chill out!"
                        (Bob.hey "WATCH OUT!")
        , skip <|
            test "shouting gibberish" <|
                \() ->
                    Expect.equal
                        "Whoa, chill out!"
                        (Bob.hey (uppercaseGibberish 10))
        , skip <|
            test "asking a question" <|
                \() ->
                    Expect.equal
                        "Sure."
                        (Bob.hey "Does this cryogenic chamber make me look fat?")
        , skip <|
            test "asking a numeric question" <|
                \() ->
                    Expect.equal
                        "Sure."
                        (Bob.hey "You are, what, like 15?")
        , skip <|
            test "asking gibberish" <|
                \() ->
                    Expect.equal
                        "Sure."
                        (Bob.hey (gibberishQuestion 20))
        , skip <|
            test "talking forcefully" <|
                \() ->
                    Expect.equal
                        "Whatever."
                        (Bob.hey "Let's go make out behind the gym!")
        , skip <|
            test "using acronyms in regular speech" <|
                \() ->
                    Expect.equal
                        "Whatever."
                        (Bob.hey "It's OK if you don't want to go to the DMV.")
        , skip <|
            test "forceful questions" <|
                \() ->
                    Expect.equal
                        "Calm down, I know what I'm doing!"
                        (Bob.hey "WHAT THE HELL WERE YOU THINKING?")
        , skip <|
            test "shouting numbers" <|
                \() ->
                    Expect.equal
                        "Whoa, chill out!"
                        (Bob.hey "1, 2, 3 GO!")
        , skip <|
            test "only numbers" <|
                \() ->
                    Expect.equal
                        "Whatever."
                        (Bob.hey "1, 2, 3")
        , skip <|
            test "question with only numbers" <|
                \() ->
                    Expect.equal
                        "Sure."
                        (Bob.hey "4?")
        , skip <|
            test "shouting with special characters" <|
                \() ->
                    Expect.equal
                        "Whoa, chill out!"
                        (Bob.hey "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!")
        , skip <|
            test "shouting with no exclamation mark" <|
                \() ->
                    Expect.equal
                        "Whoa, chill out!"
                        (Bob.hey "I HATE YOU")
        , skip <|
            test "statement containing a question mark" <|
                \() ->
                    Expect.equal
                        "Whatever."
                        (Bob.hey "Ending with ? means a question.")
        , skip <|
            test "prattling on" <|
                \() ->
                    Expect.equal
                        "Sure."
                        (Bob.hey "Wait! Hang on. Are you going to be OK?")
        , skip <|
            test "silence" <|
                \() ->
                    Expect.equal
                        "Fine. Be that way!"
                        (Bob.hey "")
        , skip <|
            test "prolonged silence" <|
                \() ->
                    Expect.equal
                        "Fine. Be that way!"
                        (Bob.hey "       ")
        , skip <|
            test "alternate silences" <|
                \() ->
                    Expect.equal
                        "Fine. Be that way!"
                        (Bob.hey "\t  \n  \t   ")
        , skip <|
            test "on multiple line questions" <|
                \() ->
                    Expect.equal
                        "Whatever."
                        (Bob.hey "\nDoes this cryogenic chamber make me look fat?\nno")
        ]


character : Int -> Int -> Random.Generator Char
character start end =
    Random.map Char.fromCode (Random.int start end)


anyCharacter : Random.Generator Char
anyCharacter =
    character 32 126


uppercaseCharacter : Random.Generator Char
uppercaseCharacter =
    character 65 90


listOfCharacters : Int -> Random.Generator Char -> Random.Generator (List Char)
listOfCharacters length characterList =
    Random.list length characterList


gibberish : Int -> Random.Generator Char -> String
gibberish length characterList =
    Tuple.first (Random.step (Random.map String.fromList (listOfCharacters length characterList)) (Random.initialSeed 424242))


uppercaseGibberish : Int -> String
uppercaseGibberish length =
    gibberish length uppercaseCharacter


gibberishQuestion : Int -> String
gibberishQuestion length =
    gibberish length anyCharacter ++ "?"
