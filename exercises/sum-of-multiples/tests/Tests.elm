module Tests exposing (..)

import Test exposing (..)
import Expect
import SumOfMultiples exposing (sumOfMultiples)


tests : Test
tests =
    describe "Sum Of Multiples"
        [ test "[3, 5] 15" <|
            \() -> Expect.equal 45 (sumOfMultiples [ 3, 5 ] 15)
        , skip <|
            test "[7, 13, 17] 20" <|
                \() -> Expect.equal 51 (sumOfMultiples [ 7, 13, 17 ] 20)
        , skip <|
            test "[4, 6] 15" <|
                \() -> Expect.equal 30 (sumOfMultiples [ 4, 6 ] 15)
        , skip <|
            test "[5, 6, 8] 150" <|
                \() -> Expect.equal 4419 (sumOfMultiples [ 5, 6, 8 ] 150)
        , skip <|
            test "[43, 47] 10000" <|
                \() -> Expect.equal 2203160 (sumOfMultiples [ 43, 47 ] 10000)
        , skip <|
            test "[5, 25] 51" <|
                \() -> Expect.equal 275 (sumOfMultiples [ 5, 25 ] 51)
        ]
