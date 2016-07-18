module Main exposing (..)

import ElmTest exposing (..)
import Pangram exposing (isPangram)


tests : Test
tests =
    suite "Pangram"
        [ test "sentence empty"
            (assertEqual False
                (isPangram "")
            )
        , test "pangram with only lower case"
            (assertEqual True
                (isPangram "the quick brown fox jumps over the lazy dog")
            )
        , test "missing character 'x'"
            (assertEqual False
                (isPangram "a quick movement of the enemy will jeopardize five gunboats")
            )
        , test "another missing character 'x'"
            (assertEqual False
                (isPangram "the quick brown fish jumps over the lazy dog")
            )
        , test "pangram with underscores"
            (assertEqual True
                (isPangram "the_quick_brown_fox_jumps_over_the_lazy_dog")
            )
        , test "pangram with numbers"
            (assertEqual True
                (isPangram "the 1 quick brown fox jumps over the 2 lazy dogs")
            )
        , test "missing letters replaced by numbers"
            (assertEqual False
                (isPangram "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog")
            )
        , test "pangram with mixed case and punctuation"
            (assertEqual True
                (isPangram "\"Five quacking Zephyrs jolt my wax bed.\"")
            )
        , test "pangram with non ascii characters"
            (assertEqual True
                (isPangram "Victor jagt zwölf Boxkämpfer quer über den großen Sylter Deich.")
            )
        ]


main : Program Never
main =
    runSuite tests
