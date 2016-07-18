module Main exposing (..)

import ElmTest exposing (..)
import Series exposing (slices)


tests : Test
tests =
    suite "Series"
        [ test "slices of one"
            (assertEqual (Ok [ [ 0 ], [ 1 ], [ 2 ], [ 3 ], [ 4 ] ])
                (slices 1 "01234")
            )
        , test "slices of two"
            (assertEqual (Ok [ [ 9, 7 ], [ 7, 8 ], [ 8, 6 ], [ 6, 7 ], [ 7, 5 ], [ 5, 6 ], [ 6, 4 ] ])
                (slices 2 "97867564")
            )
        , test "slices of three"
            (assertEqual (Ok [ [ 9, 7, 8 ], [ 7, 8, 6 ], [ 8, 6, 7 ], [ 6, 7, 5 ], [ 7, 5, 6 ], [ 5, 6, 4 ] ])
                (slices 3 "97867564")
            )
        , test "slices of four"
            (assertEqual (Ok [ [ 0, 1, 2, 3 ], [ 1, 2, 3, 4 ] ])
                (slices 4 "01234")
            )
        , test "slices of five"
            (assertEqual (Ok [ [ 0, 1, 2, 3, 4 ] ])
                (slices 5 "01234")
            )
        , test "overly long slice"
            (assertEqual (Ok [])
                (slices 4 "012")
            )
        , test "overly short slice"
            (assertEqual (Err ("Invalid size: 0"))
                (slices 0 "01234")
            )
        , test "input has non numbers"
            (assertEqual (Err "could not convert string 'a' to an Int")
                (slices 2 "0123abc")
            )
        ]


main : Program Never
main =
    runSuite tests
