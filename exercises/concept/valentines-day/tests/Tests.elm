module Tests exposing (tests)

import Expect
import Test exposing (..)
import ValentinesDay exposing (..)


tests : Test
tests =
    describe "ValentinesDay"
        [ describe "5"
            [ test "board game rated no" <|
                \_ ->
                    rateActivity BoardGame
                        |> Expect.equal No
            , test "chill rated no" <|
                \_ ->
                    rateActivity Chill
                        |> Expect.equal No
            , test "crime movie rated no" <|
                \_ ->
                    rateActivity (Movie Crime)
                        |> Expect.equal No
            , test "horror movie rated no" <|
                \_ ->
                    rateActivity (Movie Horror)
                        |> Expect.equal No
            , test "romance movie rated yes" <|
                \_ ->
                    rateActivity (Movie Romance)
                        |> Expect.equal Yes
            , test "thriller movie rated no" <|
                \_ ->
                    rateActivity (Movie Thriller)
                        |> Expect.equal No
            , test "korean restaurant rated no" <|
                \_ ->
                    rateActivity (Restaurant Korean)
                        |> Expect.equal Yes
            , test "turkish restaurant rated maybe" <|
                \_ ->
                    rateActivity (Restaurant Turkish)
                        |> Expect.equal Maybe
            ]
        ]
