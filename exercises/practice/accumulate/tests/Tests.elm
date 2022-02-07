module Tests exposing (square, tests)

import Accumulate exposing (accumulate)
import Expect
import String
import Test exposing (..)


square : Int -> Int
square x =
    x * x


tests : Test
tests =
    describe "Accumulate"
        [ test "[] Accumulate" <|
            \() -> Expect.equal [] (accumulate square [])
        , skip <|
            test "square Accumulate" <|
                \() -> Expect.equal [ 1, 4, 9 ] (accumulate square [ 1, 2, 3 ])
        , skip <|
            test "toUpper Accumulate" <|
                \() ->
                    Expect.equal [ "HELLO", "WORLD" ]
                        (accumulate String.toUpper [ "hello", "world" ])
        , skip <|
            test "reverse Accumulate" <|
                \() ->
                    Expect.equal [ "olleh", "dlrow" ]
                        (accumulate String.reverse [ "hello", "world" ])
        , skip <|
            test "accumulate recursively" <|
                \() ->
                    Expect.equal [ [ "a1", "a2", "a3" ], [ "b1", "b2", "b3" ], [ "c1", "c2", "c3" ] ]
                        (accumulate (\a -> accumulate ((++) a) [ "1", "2", "3" ]) [ "a", "b", "c" ])
        ]
