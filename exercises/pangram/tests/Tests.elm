module Tests exposing (..)

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
        , skip <|
            test "pangram with only lower case" <|
                \() ->
                    Expect.equal True
                        (isPangram "the quick brown fox jumps over the lazy dog")
        , skip <|
            test "missing character 'x'" <|
                \() ->
                    Expect.equal False
                        (isPangram "a quick movement of the enemy will jeopardize five gunboats")
        , skip <|
            test "missing character 'z'" <|
                \() ->
                    Expect.equal False
                        (isPangram "a quick movement of the enemy will jeopardixe five gunboats")
        , skip <|
            test "another missing character 'x'" <|
                \() ->
                    Expect.equal False
                        (isPangram "the quick brown fish jumps over the lazy dog")
        , skip <|
            test "pangram with underscores" <|
                \() ->
                    Expect.equal True
                        (isPangram "the_quick_brown_fox_jumps_over_the_lazy_dog")
        , skip <|
            test "pangram with numbers" <|
                \() ->
                    Expect.equal True
                        (isPangram "the 1 quick brown fox jumps over the 2 lazy dogs")
        , skip <|
            test "missing letters replaced by numbers" <|
                \() ->
                    Expect.equal False
                        (isPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
        , skip <|
            test "pangram with mixed case and punctuation" <|
                \() ->
                    Expect.equal True
                        (isPangram "\"Five quacking Zephyrs jolt my wax bed.\"")
        , skip <|
            test "pangram with non ascii characters" <|
                \() ->
                    Expect.equal True
                        (isPangram "Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich.")
        ]
