module Tests exposing (..)

import Expect
import Sublist exposing (ListComparison(..), sublist, version)
import Test exposing (..)


tests : Test
tests =
    describe "Sublist"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , test "empty equals empty" <|
            \() -> Expect.equal Equal (sublist [] [])
        , skip <|
            test "empty is a sublist of anything" <|
                \() -> Expect.equal Sublist (sublist [] [ 1, 2 ])
        , skip <|
            test "anything is a superlist of empty" <|
                \() -> Expect.equal Superlist (sublist [ 1, 2 ] [])
        , skip <|
            test "1 is not 2" <|
                \() -> Expect.equal Unequal (sublist [ 1 ] [ 2 ])
        , skip <|
            test "compare larger equal lists" <|
                \() -> Expect.equal Equal (sublist [ 1, 1, 1 ] [ 1, 1, 1 ])
        , skip <|
            test "sublist at start" <|
                \() -> Expect.equal Sublist (sublist [ 1, 2, 3 ] [ 1, 2, 3, 4, 5 ])
        , skip <|
            test "sublist in the middle" <|
                \() -> Expect.equal Sublist (sublist [ 4, 3, 2 ] [ 5, 4, 3, 2, 1 ])
        , skip <|
            test "sublist at end" <|
                \() -> Expect.equal Sublist (sublist [ 3, 4, 5 ] [ 1, 2, 3, 4, 5 ])
        , skip <|
            test "partially matching sublist at start" <|
                \() -> Expect.equal Sublist (sublist [ 1, 1, 2 ] [ 1, 1, 1, 2 ])
        , skip <|
            test "sublist early in huge list" <|
                \() -> Expect.equal Sublist (sublist [ 3, 4, 5 ] (List.range 1 100000))
        , skip <|
            test "huge sublist not in list" <|
                \() -> Expect.equal Unequal (sublist (List.range 10 5001) (List.range 1 5000))
        , skip <|
            test "superlist at start" <|
                \() -> Expect.equal Superlist (sublist [ 1, 2, 3, 4, 5 ] [ 1, 2, 3 ])
        , skip <|
            test "superlist in middle" <|
                \() -> Expect.equal Superlist (sublist [ 5, 4, 3, 2, 1 ] [ 4, 3, 2 ])
        , skip <|
            test "superlist at end" <|
                \() -> Expect.equal Superlist (sublist [ 1, 2, 3, 4, 5 ] [ 3, 4, 5 ])
        , skip <|
            test "partially matching superlist at start" <|
                \() -> Expect.equal Superlist (sublist [ 1, 1, 1, 2 ] [ 1, 1, 2 ])
        , skip <|
            test "superlist early in huge list" <|
                \() -> Expect.equal Superlist (sublist (List.range 1 100000) [ 3, 4, 5 ])
        , skip <|
            test "recurring values sublist" <|
                \() -> Expect.equal Sublist (sublist [ 1, 2, 1, 2, 3 ] [ 1, 2, 3, 1, 2, 1, 2, 3, 2, 1 ])
        , skip <|
            test "recurring values unequal" <|
                \() -> Expect.equal Unequal (sublist [ 1, 2, 1, 2, 3 ] [ 1, 2, 3, 1, 2, 3, 2, 3, 2, 1 ])
        ]
