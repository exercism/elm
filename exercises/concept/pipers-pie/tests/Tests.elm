module Tests exposing (tests)

import Expect
import PipersPie
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "PipersPie"
        [ describe "1"
            [ test "factorial of 0 is 1" <|
                \() ->
                    PipersPie.factorial 0
                        |> Expect.equal 1
            , test "factorial of 1 is 1" <|
                \() ->
                    PipersPie.factorial 1
                        |> Expect.equal 1
            , test "factorial of 5 is 120" <|
                \() ->
                    PipersPie.factorial 5
                        |> Expect.equal 120
            , test "factorial of 10 is 3628800" <|
                \() ->
                    PipersPie.factorial 10
                        |> Expect.equal 3628800
            ]
        , describe "2"
            [ test "double factorial of 0 is 1" <|
                \() ->
                    PipersPie.doubleFactorial 0
                        |> Expect.equal 1
            , test "double factorial of 1 is 1" <|
                \() ->
                    PipersPie.doubleFactorial 1
                        |> Expect.equal 1
            , test "double factorial of 2 is 2" <|
                \() ->
                    PipersPie.doubleFactorial 2
                        |> Expect.equal 2
            , test "double factorial of 3 is 3" <|
                \() ->
                    PipersPie.doubleFactorial 3
                        |> Expect.equal 3
            , test "double factorial of 4 is 8" <|
                \() ->
                    PipersPie.doubleFactorial 4
                        |> Expect.equal 8
            , test "double factorial of 5 is 15" <|
                \() ->
                    PipersPie.doubleFactorial 5
                        |> Expect.equal 15
            , test "double factorial of 8 is 384" <|
                \() ->
                    PipersPie.doubleFactorial 8
                        |> Expect.equal 384
            , test "double factorial of 10 is 3840" <|
                \() ->
                    PipersPie.doubleFactorial 10
                        |> Expect.equal 3840
            ]
        , describe "3"
            [ test "pipersPi with 0 iterations" <|
                \() ->
                    PipersPie.pipersPi 0
                        |> Expect.within (Expect.Relative 1.0e-5) 2.0
            , test "pipersPi with 1 iteration" <|
                \() ->
                    PipersPie.pipersPi 1
                        |> Expect.within (Expect.Relative 1.0e-5) 2.66666
            , test "pipersPi with 2 iterations" <|
                \() ->
                    PipersPie.pipersPi 2
                        |> Expect.within (Expect.Relative 1.0e-5) 2.933333
            , test "pipersPi with 5 iterations" <|
                \() ->
                    PipersPie.pipersPi 5
                        |> Expect.within (Expect.Relative 1.0e-5) 3.1215
            , test "pipersPi with 10 iterations" <|
                \() ->
                    PipersPie.pipersPi 10
                        |> Expect.within (Expect.Relative 1.0e-5) 3.1411
            , test "pipersPi with 100 iterations" <|
                \() ->
                    PipersPie.pipersPi 100
                        |> Expect.within (Expect.Relative 1.0e-14) 3.14159265358979
            , test "pipersPi with 1000 iterations" <|
                \() ->
                    PipersPie.pipersPi 1000
                        |> Expect.within (Expect.Relative 1.0e-15) 3.141592653589793
            ]
        ]
