module Main exposing (..)

import ElmTest exposing (..)
import Sublist exposing (version, sublist, ListComparison(..))


tests : Test
tests =
    suite "Sublist"
        [ test "the solution is for the correct version of the test"
            (assertEqual 2 version)
        , test "empty equals empty"
            (assertEqual Equal (sublist [] []))
        , test "empty is a sublist of anything"
            (assertEqual Sublist (sublist [] [ 1, 2 ]))
        , test "anything is a superlist of empty"
            (assertEqual Superlist (sublist [ 1, 2 ] []))
        , test "1 is not 2"
            (assertEqual Unequal (sublist [ 1 ] [ 2 ]))
        , test "compare larger equal lists"
            (assertEqual Equal (sublist [ 1, 1, 1 ] [ 1, 1, 1 ]))
        , test "sublist at start"
            (assertEqual Sublist (sublist [ 1, 2, 3 ] [ 1, 2, 3, 4, 5 ]))
        , test "sublist in the middle"
            (assertEqual Sublist (sublist [ 4, 3, 2 ] [ 5, 4, 3, 2, 1 ]))
        , test "sublist at end"
            (assertEqual Sublist (sublist [ 3, 4, 5 ] [ 1, 2, 3, 4, 5 ]))
        , test "partially matching sublist at start"
            (assertEqual Sublist (sublist [ 1, 1, 2 ] [ 1, 1, 1, 2 ]))
        , test "sublist early in huge list"
            (assertEqual Sublist (sublist [ 3, 4, 5 ] [1..100000]))
        , test "huge sublist not in list"
            (assertEqual Unequal (sublist [10..5001] [1..5000]))
        , test "superlist at start"
            (assertEqual Superlist (sublist [ 1, 2, 3, 4, 5 ] [ 1, 2, 3 ]))
        , test "superlist in middle"
            (assertEqual Superlist (sublist [ 5, 4, 3, 2, 1 ] [ 4, 3, 2 ]))
        , test "superlist at end"
            (assertEqual Superlist (sublist [ 1, 2, 3, 4, 5 ] [ 3, 4, 5 ]))
        , test "partially matching superlist at start"
            (assertEqual Superlist (sublist [ 1, 1, 1, 2 ] [ 1, 1, 2 ]))
        , test "superlist early in huge list"
            (assertEqual Superlist (sublist [1..100000] [ 3, 4, 5 ]))
        , test "recurring values sublist"
            (assertEqual Sublist (sublist [ 1, 2, 1, 2, 3 ] [ 1, 2, 3, 1, 2, 1, 2, 3, 2, 1 ]))
        , test "recurring values unequal"
            (assertEqual Unequal (sublist [ 1, 2, 1, 2, 3 ] [ 1, 2, 3, 1, 2, 3, 2, 3, 2, 1 ]))
        ]


main : Program Never
main =
    runSuite tests
