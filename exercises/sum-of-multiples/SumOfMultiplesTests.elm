module Main exposing (..)

import ElmTest exposing (..)
import SumOfMultiples exposing (sumOfMultiples)


tests : Test
tests =
    suite "Sum Of Multiples"
        [ test "[3, 5] 15" (assertEqual 45 (sumOfMultiples [ 3, 5 ] 15))
        , test "[7, 13, 17] 20" (assertEqual 51 (sumOfMultiples [ 7, 13, 17 ] 20))
        , test "[4, 6] 15" (assertEqual 30 (sumOfMultiples [ 4, 6 ] 15))
        , test "[5, 6, 8] 150" (assertEqual 4419 (sumOfMultiples [ 5, 6, 8 ] 150))
        , test "[43, 47] 10000" (assertEqual 2203160 (sumOfMultiples [ 43, 47 ] 10000))
        , test "[5, 25] 51" (assertEqual 275 (sumOfMultiples [ 5, 25 ] 51))
        ]


main : Program Never
main =
    runSuite tests
