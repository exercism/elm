port module Main exposing (..)

import Test.Runner.Node exposing (run, TestProgram)
import Json.Encode exposing (Value)
import Test exposing (..)
import Expect
import Pangram exposing (isPangram)


tests : Test
tests =
    describe "Pangram"
        [ test "sentence empty" <|
            \() ->
                Expect.equal False
                    (isPangram "")
        , test "pangram with only lower case" <|
            \() ->
                Expect.equal True
                    (isPangram "the quick brown fox jumps over the lazy dog")
        , test "missing character 'x'" <|
            \() ->
                Expect.equal False
                    (isPangram "a quick movement of the enemy will jeopardize five gunboats")
        , test "another missing character 'x'" <|
            \() ->
                Expect.equal False
                    (isPangram "the quick brown fish jumps over the lazy dog")
        , test "pangram with underscores" <|
            \() ->
                Expect.equal True
                    (isPangram "the_quick_brown_fox_jumps_over_the_lazy_dog")
        , test "pangram with numbers" <|
            \() ->
                Expect.equal True
                    (isPangram "the 1 quick brown fox jumps over the 2 lazy dogs")
        , test "missing letters replaced by numbers" <|
            \() ->
                Expect.equal False
                    (isPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
        , test "pangram with mixed case and punctuation" <|
            \() ->
                Expect.equal True
                    (isPangram "\"Five quacking Zephyrs jolt my wax bed.\"")
        , test "pangram with non ascii characters" <|
            \() ->
                Expect.equal True
                    (isPangram "Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich.")
        ]


main : TestProgram
main =
    run emit tests


port emit : ( String, Value ) -> Cmd msg
