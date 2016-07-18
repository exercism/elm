module Main exposing (..)

import ElmTest exposing (..)
import String
import Char
import Random
import Bob


tests : Test
tests =
    suite "Bob"
        [ test "stating something" (assertEqual "Whatever." (Bob.hey "Tom-ay-to, tom-aaaah-to."))
        , test "shouting" (assertEqual "Whoa, chill out!" (Bob.hey "WATCH OUT!"))
        , test "shouting gibberish" (assertEqual "Whoa, chill out!" (Bob.hey (uppercaseGibberish 10)))
        , test "asking a question" (assertEqual "Sure." (Bob.hey "Does this cryogenic chamber make me look fat?"))
        , test "asking a numeric question" (assertEqual "Sure." (Bob.hey "You are, what, like 15?"))
        , test "asking gibberish" (assertEqual "Sure." (Bob.hey (gibberishQuestion 20)))
        , test "talking forcefully" (assertEqual "Whatever." (Bob.hey "Let's go make out behind the gym!"))
        , test "using acronyms in regular speech" (assertEqual "Whatever." (Bob.hey "It's OK if you don't want to go to the DMV."))
        , test "forceful questions" (assertEqual "Whoa, chill out!" (Bob.hey "WHAT THE HELL WERE YOU THINKING?"))
        , test "shouting numbers" (assertEqual "Whoa, chill out!" (Bob.hey "1, 2, 3 GO!"))
        , test "only numbers" (assertEqual "Whatever." (Bob.hey "1, 2, 3"))
        , test "question with only numbers" (assertEqual "Sure." (Bob.hey "4?"))
        , test "shouting with special characters" (assertEqual "Whoa, chill out!" (Bob.hey "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!)"))
        , test "shouting with no exclamation mark" (assertEqual "Whoa, chill out!" (Bob.hey "I HATE YOU"))
        , test "statement containing a question mark" (assertEqual "Whatever." (Bob.hey "Ending with ? means a question."))
        , test "prattling on" (assertEqual "Sure." (Bob.hey "Wait! Hang on. Are you going to be OK?"))
        , test "silence" (assertEqual "Fine. Be that way!" (Bob.hey ""))
        , test "prolonged silence" (assertEqual "Fine. Be that way!" (Bob.hey "       "))
        , test "alternate silences" (assertEqual "Fine. Be that way!" (Bob.hey "\t  \n  \t   "))
        , test "on multiple line questions" (assertEqual "Whatever." (Bob.hey "\nDoes this cryogenic chamber make me look fat?\nno"))
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
    fst (Random.step (Random.map String.fromList (listOfCharacters length characterList)) (Random.initialSeed 424242))


uppercaseGibberish : Int -> String
uppercaseGibberish length =
    gibberish length uppercaseCharacter


gibberishQuestion : Int -> String
gibberishQuestion length =
    (gibberish length anyCharacter) ++ "?"


main : Program Never
main =
    runSuite tests
