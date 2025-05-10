module Tests exposing (tests)

import Expect
import KurokosClock exposing (Locale(..), showDateTime, showLocalDate, showLocalTime)
import Test exposing (Test, describe, test)
import Time exposing (Month(..), Posix, Zone)


tests : Test
tests =
    describe "KurokosClock"
        [ describe "1"
            [ test "US locale" <|
                \() ->
                    KurokosClock.showLocalDate US 2025 May 1
                        |> Expect.equal "5/1/2025"
            , test "US locale, with different date" <|
                \() ->
                    KurokosClock.showLocalDate US 2024 Dec 25
                        |> Expect.equal "12/25/2024"
            , test "JP locale" <|
                \() ->
                    KurokosClock.showLocalDate JP 2025 May 1
                        |> Expect.equal "2025年5月1日"
            , test "JP locale, with different date" <|
                \() ->
                    KurokosClock.showLocalDate JP 2024 Dec 25
                        |> Expect.equal "2024年12月25日"
            ]
        , describe "2"
            [ test "US locale, morning time" <|
                \() ->
                    KurokosClock.showLocalTime US 8 5
                        |> Expect.equal "8:05 AM"
            , test "US locale, afternoon time" <|
                \() ->
                    KurokosClock.showLocalTime US 13 8
                        |> Expect.equal "1:08 PM"
            , test "US locale, midnight" <|
                \() ->
                    KurokosClock.showLocalTime US 0 0
                        |> Expect.equal "12:00 AM"
            , test "US locale, noon" <|
                \() ->
                    KurokosClock.showLocalTime US 12 0
                        |> Expect.equal "12:00 PM"
            , test "JP locale, morning time" <|
                \() ->
                    KurokosClock.showLocalTime JP 8 5
                        |> Expect.equal "8時5分"
            , test "JP locale, afternoon time" <|
                \() ->
                    KurokosClock.showLocalTime JP 13 15
                        |> Expect.equal "13時15分"
            , test "JP locale, midnight" <|
                \() ->
                    KurokosClock.showLocalTime JP 0 0
                        |> Expect.equal "0時0分"
            , test "JP locale, noon" <|
                \() ->
                    KurokosClock.showLocalTime JP 12 0
                        |> Expect.equal "12時0分"
            ]
        , describe "3"
            [ test "US locale, UTC, epoch" <|
                \() ->
                    KurokosClock.showDateTime US Time.utc (Time.millisToPosix 0)
                        |> Expect.equal "1/1/1970 12:00 AM"
            , test "US locale, UTC, Elm compiler first commit" <|
                \() ->
                    KurokosClock.showDateTime US Time.utc (Time.millisToPosix 1334816640000)
                        |> Expect.equal "4/19/2012 6:24 AM"
            , test "US locale, Cambridge, MA summer time zone, Elm compiler first commit" <|
                \() ->
                    KurokosClock.showDateTime US
                        (Time.customZone (-4 * 60) [])
                        (Time.millisToPosix 1334816640000)
                        |> Expect.equal "4/19/2012 2:24 AM"
            , test "JP locale, UTC, epoch" <|
                \() ->
                    KurokosClock.showDateTime JP Time.utc (Time.millisToPosix 0)
                        |> Expect.equal "1970年1月1日0時0分"
            , test "JP locale, UTC, Elm compiler first commit" <|
                \() ->
                    KurokosClock.showDateTime JP Time.utc (Time.millisToPosix 1334816640000)
                        |> Expect.equal "2012年4月19日6時24分"
            , test "JP locale, Tokyo time zone, Elm compiler first commit" <|
                \() ->
                    KurokosClock.showDateTime JP
                        (Time.customZone (9 * 60) [])
                        (Time.millisToPosix 1334816640000)
                        |> Expect.equal "2012年4月19日15時24分"
            ]
        ]
