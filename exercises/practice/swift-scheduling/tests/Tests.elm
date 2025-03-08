module Tests exposing (tests)

import Expect
import SwiftScheduling
import Test exposing (Test, describe, skip, test)
import Time exposing (Month(..))


tests : Test
tests =
    describe "SwiftScheduling"
        [ -- skip <|
          test "NOW translates to two hours later" <|
            \() ->
                -- 2012-02-13T09:00:00
                SwiftScheduling.deliveryDate (Time.millisToPosix 1329123600000) "NOW"
                    |> Expect.all
                        [ Time.toYear Time.utc >> Expect.equal 2012
                        , Time.toMonth Time.utc >> Expect.equal Feb
                        , Time.toDay Time.utc >> Expect.equal 13
                        , Time.toHour Time.utc >> Expect.equal 11
                        , Time.toMinute Time.utc >> Expect.equal 0
                        , Time.toSecond Time.utc >> Expect.equal 0
                        ]
        , skip <|
            test "ASAP before one in the afternoon translates to today at five in the afternoon" <|
                \() ->
                    -- 1999-06-03T09:45:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 928403100000) "ASAP"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 1999
                            , Time.toMonth Time.utc >> Expect.equal Jun
                            , Time.toDay Time.utc >> Expect.equal 3
                            , Time.toHour Time.utc >> Expect.equal 17
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "ASAP at one in the afternoon translates to tomorrow at one in the afternoon" <|
                \() ->
                    -- 2008-12-21T13:00:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1229864400000) "ASAP"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2008
                            , Time.toMonth Time.utc >> Expect.equal Dec
                            , Time.toDay Time.utc >> Expect.equal 22
                            , Time.toHour Time.utc >> Expect.equal 13
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "ASAP after one in the afternoon translates to tomorrow at one in the afternoon" <|
                \() ->
                    -- 2008-12-21T14:50:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1229871000000) "ASAP"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2008
                            , Time.toMonth Time.utc >> Expect.equal Dec
                            , Time.toDay Time.utc >> Expect.equal 22
                            , Time.toHour Time.utc >> Expect.equal 13
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "EOW on Monday translates to Friday at five in the afternoon" <|
                \() ->
                    -- 2025-02-03T16:00:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1738598400000) "EOW"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2025
                            , Time.toMonth Time.utc >> Expect.equal Feb
                            , Time.toDay Time.utc >> Expect.equal 7
                            , Time.toHour Time.utc >> Expect.equal 17
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "EOW on Tuesday translates to Friday at five in the afternoon" <|
                \() ->
                    -- 1997-04-29T10:50:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 862311000000) "EOW"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 1997
                            , Time.toMonth Time.utc >> Expect.equal May
                            , Time.toDay Time.utc >> Expect.equal 2
                            , Time.toHour Time.utc >> Expect.equal 17
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "EOW on Wednesday translates to Friday at five in the afternoon" <|
                \() ->
                    -- 2005-09-14T11:00:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1126695600000) "EOW"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2005
                            , Time.toMonth Time.utc >> Expect.equal Sep
                            , Time.toDay Time.utc >> Expect.equal 16
                            , Time.toHour Time.utc >> Expect.equal 17
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "EOW on Thursday translates to Sunday at eight in the evening" <|
                \() ->
                    -- 2011-05-19T08:30:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1305793800000) "EOW"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2011
                            , Time.toMonth Time.utc >> Expect.equal May
                            , Time.toDay Time.utc >> Expect.equal 22
                            , Time.toHour Time.utc >> Expect.equal 20
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "EOW on Friday translates to Sunday at eight in the evening" <|
                \() ->
                    -- 2022-08-05T14:00:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1659708000000) "EOW"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2022
                            , Time.toMonth Time.utc >> Expect.equal Aug
                            , Time.toDay Time.utc >> Expect.equal 7
                            , Time.toHour Time.utc >> Expect.equal 20
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "EOW translates to leap day" <|
                \() ->
                    -- 2008-02-25T10:30:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1203935400000) "EOW"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2008
                            , Time.toMonth Time.utc >> Expect.equal Feb
                            , Time.toDay Time.utc >> Expect.equal 29
                            , Time.toHour Time.utc >> Expect.equal 17
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "2M before the second month of this year translates to the first workday of the second month of this year" <|
                \() ->
                    -- 2007-01-02T14:15:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1167747300000) "2M"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2007
                            , Time.toMonth Time.utc >> Expect.equal Feb
                            , Time.toDay Time.utc >> Expect.equal 1
                            , Time.toHour Time.utc >> Expect.equal 8
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "11M in the eleventh month translates to the first workday of the eleventh month of next year" <|
                \() ->
                    -- 2013-11-21T15:30:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1385047800000) "11M"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2014
                            , Time.toMonth Time.utc >> Expect.equal Nov
                            , Time.toDay Time.utc >> Expect.equal 3
                            , Time.toHour Time.utc >> Expect.equal 8
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "4M in the ninth month translates to the first workday of the fourth month of next year" <|
                \() ->
                    -- 2019-11-18T15:15:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1574090100000) "4M"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2020
                            , Time.toMonth Time.utc >> Expect.equal Apr
                            , Time.toDay Time.utc >> Expect.equal 1
                            , Time.toHour Time.utc >> Expect.equal 8
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "Q1 in the first quarter translates to the last workday of the first quarter of this year" <|
                \() ->
                    -- 2003-01-01T10:45:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1041417900000) "Q1"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2003
                            , Time.toMonth Time.utc >> Expect.equal Mar
                            , Time.toDay Time.utc >> Expect.equal 31
                            , Time.toHour Time.utc >> Expect.equal 8
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "Q4 in the second quarter translates to the last workday of the fourth quarter of this year" <|
                \() ->
                    -- 2001-04-09T09:00:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 986806800000) "Q4"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2001
                            , Time.toMonth Time.utc >> Expect.equal Dec
                            , Time.toDay Time.utc >> Expect.equal 31
                            , Time.toHour Time.utc >> Expect.equal 8
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        , skip <|
            test "Q3 in the fourth quarter translates to the last workday of the third quarter of next year" <|
                \() ->
                    -- 2022-10-06T11:00:00
                    SwiftScheduling.deliveryDate (Time.millisToPosix 1665054000000) "Q3"
                        |> Expect.all
                            [ Time.toYear Time.utc >> Expect.equal 2023
                            , Time.toMonth Time.utc >> Expect.equal Sep
                            , Time.toDay Time.utc >> Expect.equal 29
                            , Time.toHour Time.utc >> Expect.equal 8
                            , Time.toMinute Time.utc >> Expect.equal 0
                            , Time.toSecond Time.utc >> Expect.equal 0
                            ]
        ]
