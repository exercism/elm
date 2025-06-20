module Tests exposing (tests)

import Expect
import SplitSecondStopwatch exposing (State(..), Stopwatch)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "SplitSecondStopwatch"
        [ -- skip <|
          test "new stopwatch starts in ready state" <|
            \() ->
                SplitSecondStopwatch.new
                    |> SplitSecondStopwatch.state
                    |> Expect.equal Ready
        , skip <|
            test "new stopwatch's current lap has no elapsed time" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.currentLap
                        |> Expect.equal "00:00:00"
        , skip <|
            test "new stopwatch's total has no elapsed time" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.total
                        |> Expect.equal "00:00:00"
        , skip <|
            test "new stopwatch does not have previous laps" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.previousLaps
                        |> Expect.equal []
        , skip <|
            test "start from ready state changes state to running" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map SplitSecondStopwatch.state
                        |> Expect.equal (Ok Running)
        , skip <|
            test "start does not change previous laps" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map SplitSecondStopwatch.previousLaps
                        |> Expect.equal (Ok [])
        , skip <|
            test "start initiates time tracking for current lap" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:05")
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Expect.equal (Ok "00:00:05")
        , skip <|
            test "start initiates time tracking for total" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:23")
                        |> Result.map SplitSecondStopwatch.total
                        |> Expect.equal (Ok "00:00:23")
        , skip <|
            test "start cannot be called from running state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.start
                        |> Expect.equal (Err "cannot start an already running stopwatch")
        , skip <|
            test "stop from running state changes state to stopped" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.map SplitSecondStopwatch.state
                        |> Expect.equal (Ok Stopped)
        , skip <|
            test "stop pauses time tracking for current lap" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:05")
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:08")
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Expect.equal (Ok "00:00:05")
        , skip <|
            test "stop pauses time tracking for total" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:13")
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:44")
                        |> Result.map SplitSecondStopwatch.total
                        |> Expect.equal (Ok "00:00:13")
        , skip <|
            test "stop cannot be called from ready state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.stop
                        |> Expect.equal (Err "cannot stop a stopwatch that is not running")
        , skip <|
            test "stop cannot be called from stopped state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Expect.equal (Err "cannot stop a stopwatch that is not running")
        , skip <|
            test "start from stopped state changes state to running" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.andThen SplitSecondStopwatch.start
                        |> Result.map SplitSecondStopwatch.state
                        |> Expect.equal (Ok Running)
        , skip <|
            test "start from stopped state resumes time tracking for current lap" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:01:20")
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:20")
                        |> Result.andThen SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:08")
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Expect.equal (Ok "00:01:28")
        , skip <|
            test "start from stopped state resumes time tracking for total" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:23")
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:44")
                        |> Result.andThen SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:09")
                        |> Result.map SplitSecondStopwatch.total
                        |> Expect.equal (Ok "00:00:32")
        , skip <|
            test "lap adds current lap to previous laps" <|
                \() ->
                    let
                        stopwatch1 : Result String Stopwatch
                        stopwatch1 =
                            SplitSecondStopwatch.new
                                |> SplitSecondStopwatch.start
                                |> Result.map (SplitSecondStopwatch.advanceTime "00:01:38")
                                |> Result.andThen SplitSecondStopwatch.lap

                        stopwatch2 : Result String Stopwatch
                        stopwatch2 =
                            stopwatch1
                                |> Result.map (SplitSecondStopwatch.advanceTime "00:00:44")
                                |> Result.andThen SplitSecondStopwatch.lap
                    in
                    [ Result.map SplitSecondStopwatch.previousLaps stopwatch1
                    , Result.map SplitSecondStopwatch.previousLaps stopwatch2
                    ]
                        |> Expect.equalLists
                            [ Ok [ "00:01:38" ]
                            , Ok [ "00:01:38", "00:00:44" ]
                            ]
        , skip <|
            test "lap resets current lap and resumes time tracking" <|
                \() ->
                    let
                        stopwatch1 : Result String Stopwatch
                        stopwatch1 =
                            SplitSecondStopwatch.new
                                |> SplitSecondStopwatch.start
                                |> Result.map (SplitSecondStopwatch.advanceTime "00:08:22")
                                |> Result.andThen SplitSecondStopwatch.lap

                        stopwatch2 : Result String Stopwatch
                        stopwatch2 =
                            Result.map (SplitSecondStopwatch.advanceTime "00:00:15") stopwatch1
                    in
                    [ Result.map SplitSecondStopwatch.currentLap stopwatch1
                    , Result.map SplitSecondStopwatch.currentLap stopwatch2
                    ]
                        |> Expect.equalLists
                            [ Ok "00:00:00"
                            , Ok "00:00:15"
                            ]
        , skip <|
            test "lap continues time tracking for total" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:22")
                        |> Result.andThen SplitSecondStopwatch.lap
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:33")
                        |> Result.map SplitSecondStopwatch.total
                        |> Expect.equal (Ok "00:00:55")
        , skip <|
            test "lap cannot be called from ready state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.lap
                        |> Expect.equal (Err "cannot lap a stopwatch that is not running")
        , skip <|
            test "lap cannot be called from stopped state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.andThen SplitSecondStopwatch.lap
                        |> Expect.equal (Err "cannot lap a stopwatch that is not running")
        , skip <|
            test "stop does not change previous laps" <|
                \() ->
                    let
                        stopwatch1 : Result String Stopwatch
                        stopwatch1 =
                            SplitSecondStopwatch.new
                                |> SplitSecondStopwatch.start
                                |> Result.map (SplitSecondStopwatch.advanceTime "00:11:22")
                                |> Result.andThen SplitSecondStopwatch.lap

                        stopwatch2 : Result String Stopwatch
                        stopwatch2 =
                            stopwatch1
                                |> Result.andThen SplitSecondStopwatch.stop
                    in
                    [ Result.map SplitSecondStopwatch.previousLaps stopwatch1
                    , Result.map SplitSecondStopwatch.previousLaps stopwatch2
                    ]
                        |> Expect.equalLists
                            [ Ok [ "00:11:22" ]
                            , Ok [ "00:11:22" ]
                            ]
        , skip <|
            test "reset from stopped state changes state to ready" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.andThen SplitSecondStopwatch.reset
                        |> Result.map SplitSecondStopwatch.state
                        |> Expect.equal (Ok Ready)
        , skip <|
            test "reset resets current lap" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.map (SplitSecondStopwatch.advanceTime "00:00:10")
                        |> Result.andThen SplitSecondStopwatch.stop
                        |> Result.andThen SplitSecondStopwatch.reset
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Expect.equal (Ok "00:00:00")
        , skip <|
            test "reset clears previous laps" <|
                \() ->
                    let
                        stopwatch1 : Result String Stopwatch
                        stopwatch1 =
                            SplitSecondStopwatch.new
                                |> SplitSecondStopwatch.start
                                |> Result.map (SplitSecondStopwatch.advanceTime "00:00:10")
                                |> Result.andThen SplitSecondStopwatch.lap
                                |> Result.map (SplitSecondStopwatch.advanceTime "00:00:20")
                                |> Result.andThen SplitSecondStopwatch.lap

                        stopwatch2 =
                            stopwatch1
                                |> Result.andThen SplitSecondStopwatch.stop
                                |> Result.andThen SplitSecondStopwatch.reset
                    in
                    [ Result.map SplitSecondStopwatch.previousLaps stopwatch1
                    , Result.map SplitSecondStopwatch.previousLaps stopwatch2
                    ]
                        |> Expect.equalLists
                            [ Ok [ "00:00:10", "00:00:20" ]
                            , Ok []
                            ]
        , skip <|
            test "reset cannot be called from ready state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.reset
                        |> Expect.equal (Err "cannot reset a stopwatch that is not stopped")
        , skip <|
            test "reset cannot be called from running state" <|
                \() ->
                    SplitSecondStopwatch.new
                        |> SplitSecondStopwatch.start
                        |> Result.andThen SplitSecondStopwatch.reset
                        |> Expect.equal (Err "cannot reset a stopwatch that is not stopped")
        , skip <|
            test "supports very long laps" <|
                \() ->
                    let
                        stopwatch1 : Result String Stopwatch
                        stopwatch1 =
                            SplitSecondStopwatch.new
                                |> SplitSecondStopwatch.start
                                |> Result.map (SplitSecondStopwatch.advanceTime "01:23:45")

                        stopwatch2 : Result String Stopwatch
                        stopwatch2 =
                            stopwatch1
                                |> Result.andThen SplitSecondStopwatch.lap

                        stopwatch3 : Result String Stopwatch
                        stopwatch3 =
                            stopwatch2
                                |> Result.map (SplitSecondStopwatch.advanceTime "04:01:40")

                        stopwatch4 : Result String Stopwatch
                        stopwatch4 =
                            stopwatch3
                                |> Result.andThen SplitSecondStopwatch.lap

                        stopwatch5 : Result String Stopwatch
                        stopwatch5 =
                            stopwatch4
                                |> Result.map (SplitSecondStopwatch.advanceTime "08:43:05")

                        stopwatch6 : Result String Stopwatch
                        stopwatch6 =
                            stopwatch5
                                |> Result.andThen SplitSecondStopwatch.lap
                    in
                    [ stopwatch1
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Result.map (\lap -> "currentLap: " ++ lap)
                    , stopwatch2
                        |> Result.map SplitSecondStopwatch.previousLaps
                        |> Result.map (\laps -> "previousLaps: " ++ String.join ", " laps)
                    , stopwatch3
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Result.map (\lap -> "currentLap: " ++ lap)
                    , stopwatch3
                        |> Result.map SplitSecondStopwatch.total
                        |> Result.map (\total -> "total: " ++ total)
                    , stopwatch4
                        |> Result.map SplitSecondStopwatch.previousLaps
                        |> Result.map (\laps -> "previousLaps: " ++ String.join ", " laps)
                    , stopwatch5
                        |> Result.map SplitSecondStopwatch.currentLap
                        |> Result.map (\lap -> "currentLap: " ++ lap)
                    , stopwatch5
                        |> Result.map SplitSecondStopwatch.total
                        |> Result.map (\total -> "total: " ++ total)
                    , stopwatch6
                        |> Result.map SplitSecondStopwatch.previousLaps
                        |> Result.map (\laps -> "previousLaps: " ++ String.join ", " laps)
                    ]
                        |> Expect.equalLists
                            [ Ok "currentLap: 01:23:45"
                            , Ok "previousLaps: 01:23:45"
                            , Ok "currentLap: 04:01:40"
                            , Ok "total: 05:25:25"
                            , Ok "previousLaps: 01:23:45, 04:01:40"
                            , Ok "currentLap: 08:43:05"
                            , Ok "total: 14:08:30"
                            , Ok "previousLaps: 04:01:40, 01:23:45, 08:43:05"
                            ]
        ]
