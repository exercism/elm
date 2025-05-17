module Tests exposing (tests)

import BirdCount
import Expect
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "BirdCount"
        [ describe "1"
            [ test "returns Nothing if no bird watching data recorded" <|
                \_ ->
                    BirdCount.today []
                        |> Expect.equal Nothing
            , test "with one day of data" <|
                \_ ->
                    BirdCount.today [ 5 ]
                        |> Expect.equal (Just 5)
            , test "with multiple days of data" <|
                \_ ->
                    BirdCount.today [ 2, 4, 11, 10, 6, 8 ]
                        |> Expect.equal (Just 2)
            ]
        , describe "2"
            [ test "creates entry for today if no bird watching data recorded" <|
                \_ ->
                    BirdCount.incrementDayCount []
                        |> Expect.equal [ 1 ]
            , test "with one day of data" <|
                \_ ->
                    BirdCount.incrementDayCount [ 5 ]
                        |> Expect.equal [ 6 ]
            , test "with multiple days of data" <|
                \_ ->
                    BirdCount.incrementDayCount [ 4, 2, 1, 0, 10 ]
                        |> Expect.equal [ 5, 2, 1, 0, 10 ]
            ]
        , describe "3"
            [ test "False if no bird watching data recorded" <|
                \_ ->
                    BirdCount.hasDayWithoutBirds []
                        |> Expect.equal False
            , test "False if there is a single non-zero entry" <|
                \_ ->
                    BirdCount.hasDayWithoutBirds [ 1 ]
                        |> Expect.equal False
            , test "False if there are only non-zero entries" <|
                \_ ->
                    BirdCount.hasDayWithoutBirds [ 6, 7, 10, 2, 5 ]
                        |> Expect.equal False
            , test "True if the data is a single zero" <|
                \_ ->
                    BirdCount.hasDayWithoutBirds [ 0 ]
                        |> Expect.equal True
            , test "True if the data has one zero" <|
                \_ ->
                    BirdCount.hasDayWithoutBirds [ 4, 4, 0, 1 ]
                        |> Expect.equal True
            , test "True if the data has multiple zeros" <|
                \_ ->
                    BirdCount.hasDayWithoutBirds [ 0, 0, 3, 0, 5, 6, 0 ]
                        |> Expect.equal True
            ]
        , describe "4"
            [ test "zero if no bird watching data recorded" <|
                \_ ->
                    BirdCount.total []
                        |> Expect.equal 0
            , test "with one day of data" <|
                \_ ->
                    BirdCount.total [ 5 ]
                        |> Expect.equal 5
            , test "with multiple days of data" <|
                \_ ->
                    BirdCount.total [ 3, 0, 0, 4, 4, 0, 0, 10 ]
                        |> Expect.equal 21
            ]
        , describe "5"
            [ test "zero if no bird watching data recorded" <|
                \_ ->
                    BirdCount.busyDays []
                        |> Expect.equal 0
            , test "with a single non-busy day" <|
                \_ ->
                    BirdCount.busyDays [ 1 ]
                        |> Expect.equal 0
            , test "with several days including one busy day" <|
                \_ ->
                    BirdCount.busyDays [ 0, 5 ]
                        |> Expect.equal 1
            , test "with several busy days" <|
                \_ ->
                    BirdCount.busyDays [ 0, 6, 10, 4, 4, 5, 0 ]
                        |> Expect.equal 3
            ]
        ]
