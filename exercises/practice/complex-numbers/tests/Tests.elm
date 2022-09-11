module Tests exposing (tests)

import ComplexNumbers as Complex exposing (Complex)
import Expect exposing (Expectation, FloatingPointTolerance(..))
import Test exposing (Test, describe, skip, test)


tolerance : FloatingPointTolerance
tolerance =
    Absolute 0.00001


approximatelyEqual : Complex -> Complex -> Expectation
approximatelyEqual z1 z2 =
    Complex.sub z1 z2
        |> Expect.all
            [ Complex.real >> Expect.within tolerance 0
            , Complex.imaginary >> Expect.within tolerance 0
            ]


tests : Test
tests =
    describe "ComplexNumbers"
        [ describe "Real part"
            [ test "Real part of a purely real number" <|
                \() ->
                    Complex.real (Complex.fromPair ( 1, 0 ))
                        |> Expect.within tolerance 1
            , skip <|
                test "Real part of a purely imaginary number" <|
                    \() ->
                        Complex.real (Complex.fromPair ( 0, 1 ))
                            |> Expect.within tolerance 0
            , skip <|
                test "Real part of a number with real and imaginary part" <|
                    \() ->
                        Complex.real (Complex.fromPair ( 1, 2 ))
                            |> Expect.within tolerance 1
            ]
        , describe "Imaginary part"
            [ skip <|
                test "Imaginary part of a purely real number" <|
                    \() ->
                        Complex.imaginary (Complex.fromPair ( 1, 0 ))
                            |> Expect.within tolerance 0
            , skip <|
                test "Imaginary part of a purely imaginary number" <|
                    \() ->
                        Complex.imaginary (Complex.fromPair ( 0, 1 ))
                            |> Expect.within tolerance 1
            , skip <|
                test "Imaginary part of a number with real and imaginary part" <|
                    \() ->
                        Complex.imaginary (Complex.fromPair ( 1, 2 ))
                            |> Expect.within tolerance 2
            ]
        , skip <|
            test "Imaginary unit" <|
                \() ->
                    Complex.mul (Complex.fromPair ( 0, 1 )) (Complex.fromPair ( 0, 1 ))
                        |> approximatelyEqual (Complex.fromPair ( -1, 0 ))
        , describe "Arithmetic"
            [ describe "Addition"
                [ skip <|
                    test "Add purely real numbers" <|
                        \() ->
                            Complex.add (Complex.fromPair ( 1, 0 )) (Complex.fromPair ( 2, 0 ))
                                |> approximatelyEqual (Complex.fromPair ( 3, 0 ))
                , skip <|
                    test "Add purely imaginary numbers" <|
                        \() ->
                            Complex.add (Complex.fromPair ( 0, 1 )) (Complex.fromPair ( 0, 2 ))
                                |> approximatelyEqual (Complex.fromPair ( 0, 3 ))
                , skip <|
                    test "Add numbers with real and imaginary part" <|
                        \() ->
                            Complex.add (Complex.fromPair ( 1, 2 )) (Complex.fromPair ( 3, 4 ))
                                |> approximatelyEqual (Complex.fromPair ( 4, 6 ))
                ]
            , describe "Subtraction"
                [ skip <|
                    test "Subtract purely real numbers" <|
                        \() ->
                            Complex.sub (Complex.fromPair ( 1, 0 )) (Complex.fromPair ( 2, 0 ))
                                |> approximatelyEqual (Complex.fromPair ( -1, 0 ))
                , skip <|
                    test "Subtract purely imaginary numbers" <|
                        \() ->
                            Complex.sub (Complex.fromPair ( 0, 1 )) (Complex.fromPair ( 0, 2 ))
                                |> approximatelyEqual (Complex.fromPair ( 0, -1 ))
                , skip <|
                    test "Subtract numbers with real and imaginary part" <|
                        \() ->
                            Complex.sub (Complex.fromPair ( 1, 2 )) (Complex.fromPair ( 3, 4 ))
                                |> approximatelyEqual (Complex.fromPair ( -2, -2 ))
                ]
            , describe "Multiplication"
                [ skip <|
                    test "Multiply purely real numbers" <|
                        \() ->
                            Complex.mul (Complex.fromPair ( 1, 0 )) (Complex.fromPair ( 2, 0 ))
                                |> approximatelyEqual (Complex.fromPair ( 2, 0 ))
                , skip <|
                    test "Multiply purely imaginary numbers" <|
                        \() ->
                            Complex.mul (Complex.fromPair ( 0, 1 )) (Complex.fromPair ( 0, 2 ))
                                |> approximatelyEqual (Complex.fromPair ( -2, 0 ))
                , skip <|
                    test "Multiply numbers with real and imaginary part" <|
                        \() ->
                            Complex.mul (Complex.fromPair ( 1, 2 )) (Complex.fromPair ( 3, 4 ))
                                |> approximatelyEqual (Complex.fromPair ( -5, 10 ))
                ]
            , describe "Division"
                [ skip <|
                    test "Divide purely real numbers" <|
                        \() ->
                            Complex.div (Complex.fromPair ( 1, 0 )) (Complex.fromPair ( 2, 0 ))
                                |> approximatelyEqual (Complex.fromPair ( 0.5, 0 ))
                , skip <|
                    test "Divide purely imaginary numbers" <|
                        \() ->
                            Complex.div (Complex.fromPair ( 0, 1 )) (Complex.fromPair ( 0, 2 ))
                                |> approximatelyEqual (Complex.fromPair ( 0.5, 0 ))
                , skip <|
                    test "Divide numbers with real and imaginary part" <|
                        \() ->
                            Complex.div (Complex.fromPair ( 1, 2 )) (Complex.fromPair ( 3, 4 ))
                                |> approximatelyEqual (Complex.fromPair ( 0.44, 0.08 ))
                ]
            ]
        , describe "Absolute value"
            [ skip <|
                test "Absolute value of a positive purely real number" <|
                    \() ->
                        Complex.abs (Complex.fromPair ( 5, 0 ))
                            |> Expect.within tolerance 5
            , skip <|
                test "Absolute value of a negative purely real number" <|
                    \() ->
                        Complex.abs (Complex.fromPair ( -5, 0 ))
                            |> Expect.within tolerance 5
            , skip <|
                test "Absolute value of a purely imaginary number with positive imaginary part" <|
                    \() ->
                        Complex.abs (Complex.fromPair ( 0, 5 ))
                            |> Expect.within tolerance 5
            , skip <|
                test "Absolute value of a purely imaginary number with negative imaginary part" <|
                    \() ->
                        Complex.abs (Complex.fromPair ( 0, -5 ))
                            |> Expect.within tolerance 5
            , skip <|
                test "Absolute value of a number with real and imaginary part" <|
                    \() ->
                        Complex.abs (Complex.fromPair ( 3, 4 ))
                            |> Expect.within tolerance 5
            ]
        , describe "Complex conjugate"
            [ skip <|
                test "Conjugate a purely real number" <|
                    \() ->
                        Complex.conjugate (Complex.fromPair ( 5, 0 ))
                            |> approximatelyEqual (Complex.fromPair ( 5, 0 ))
            , skip <|
                test "Conjugate a purely imaginary number" <|
                    \() ->
                        Complex.conjugate (Complex.fromPair ( 0, 5 ))
                            |> approximatelyEqual (Complex.fromPair ( 0, -5 ))
            , skip <|
                test "Conjugate a number with real and imaginary part" <|
                    \() ->
                        Complex.conjugate (Complex.fromPair ( 1, 1 ))
                            |> approximatelyEqual (Complex.fromPair ( 1, -1 ))
            ]
        , describe "Complex exponential function"
            [ skip <|
                test "Euler's identity/formula" <|
                    \() ->
                        Complex.exp (Complex.fromPair ( 0, pi ))
                            |> approximatelyEqual (Complex.fromPair ( -1, 0 ))
            , skip <|
                test "Exponential of 0" <|
                    \() ->
                        Complex.exp (Complex.fromPair ( 0, 0 ))
                            |> approximatelyEqual (Complex.fromPair ( 1, 0 ))
            , skip <|
                test "Exponential of a purely real number" <|
                    \() ->
                        Complex.exp (Complex.fromPair ( 1, 0 ))
                            |> approximatelyEqual (Complex.fromPair ( e, 0 ))
            , skip <|
                test "Exponential of a number with real and imaginary part" <|
                    \() ->
                        Complex.exp (Complex.fromPair ( logBase e 2, pi ))
                            |> approximatelyEqual (Complex.fromPair ( -2, 0 ))
            , skip <|
                test "Exponential resulting in a number with real and imaginary part" <|
                    \() ->
                        Complex.exp (Complex.fromPair ( logBase e 2 / 2, pi / 4 ))
                            |> approximatelyEqual (Complex.fromPair ( 1, 1 ))
            ]
        , describe "Operations between real numbers and complex numbers"
            [ skip <|
                test "Add real number to complex number" <|
                    \() ->
                        Complex.add (Complex.fromPair ( 1, 2 )) (Complex.fromReal 5)
                            |> approximatelyEqual (Complex.fromPair ( 6, 2 ))
            , skip <|
                test "Add complex number to real number" <|
                    \() ->
                        Complex.add (Complex.fromReal 5) (Complex.fromPair ( 1, 2 ))
                            |> approximatelyEqual (Complex.fromPair ( 6, 2 ))
            , skip <|
                test "Subtract real number from complex number" <|
                    \() ->
                        Complex.sub (Complex.fromPair ( 5, 7 )) (Complex.fromReal 4)
                            |> approximatelyEqual (Complex.fromPair ( 1, 7 ))
            , skip <|
                test "Subtract complex number from real number" <|
                    \() ->
                        Complex.sub (Complex.fromReal 4) (Complex.fromPair ( 5, 7 ))
                            |> approximatelyEqual (Complex.fromPair ( -1, -7 ))
            , skip <|
                test "Multiply complex number by real number" <|
                    \() ->
                        Complex.mul (Complex.fromPair ( 2, 5 )) (Complex.fromReal 5)
                            |> approximatelyEqual (Complex.fromPair ( 10, 25 ))
            , skip <|
                test "Multiply real number by complex number" <|
                    \() ->
                        Complex.mul (Complex.fromReal 5) (Complex.fromPair ( 2, 5 ))
                            |> approximatelyEqual (Complex.fromPair ( 10, 25 ))
            , skip <|
                test "Divide complex number by real number" <|
                    \() ->
                        Complex.div (Complex.fromPair ( 10, 100 )) (Complex.fromReal 10)
                            |> approximatelyEqual (Complex.fromPair ( 1, 10 ))
            , skip <|
                test "Divide real number by complex number" <|
                    \() ->
                        Complex.div (Complex.fromReal 5) (Complex.fromPair ( 1, 1 ))
                            |> approximatelyEqual (Complex.fromPair ( 2.5, -2.5 ))
            ]
        ]
