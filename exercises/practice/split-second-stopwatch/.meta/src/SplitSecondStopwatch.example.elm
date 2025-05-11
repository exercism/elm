module SplitSecondStopwatch exposing
    ( State(..)
    , Stopwatch
    , advanceTime
    , currentLap
    , lap
    , new
    , previousLaps
    , reset
    , start
    , state
    , stop
    , total
    )


type State
    = Ready
    | Running
    | Stopped


type Stopwatch
    = Stopwatch
        { state_ : State
        , currentLap_ : Int
        , previousLaps_ : List Int
        }


new : Stopwatch
new =
    Stopwatch { state_ = Ready, currentLap_ = 0, previousLaps_ = [] }


state : Stopwatch -> State
state (Stopwatch { state_ }) =
    state_


currentLap : Stopwatch -> String
currentLap (Stopwatch { currentLap_ }) =
    formatTime currentLap_


previousLaps : Stopwatch -> List String
previousLaps (Stopwatch { previousLaps_ }) =
    previousLaps_
        |> List.reverse
        |> List.map formatTime


advanceTime : String -> Stopwatch -> Stopwatch
advanceTime time (Stopwatch ({ state_, currentLap_ } as stopwatch)) =
    case state_ of
        Running ->
            Stopwatch { stopwatch | currentLap_ = currentLap_ + parseTime time }

        _ ->
            Stopwatch stopwatch


total : Stopwatch -> String
total (Stopwatch { currentLap_, previousLaps_ }) =
    (currentLap_ :: previousLaps_)
        |> List.sum
        |> formatTime


start : Stopwatch -> Result String Stopwatch
start (Stopwatch ({ state_ } as stopwatch)) =
    case state_ of
        Running ->
            Err "cannot start an already running stopwatch"

        _ ->
            Ok (Stopwatch { stopwatch | state_ = Running })


stop : Stopwatch -> Result String Stopwatch
stop (Stopwatch ({ state_ } as stopwatch)) =
    case state_ of
        Running ->
            Ok (Stopwatch { stopwatch | state_ = Stopped })

        _ ->
            Err "cannot stop a stopwatch that is not running"


lap : Stopwatch -> Result String Stopwatch
lap (Stopwatch ({ state_, currentLap_, previousLaps_ } as stopwatch)) =
    case state_ of
        Running ->
            Ok (Stopwatch { stopwatch | currentLap_ = 0, previousLaps_ = currentLap_ :: previousLaps_ })

        _ ->
            Err "cannot lap a stopwatch that is not running"


reset : Stopwatch -> Result String Stopwatch
reset (Stopwatch { state_ }) =
    case state_ of
        Stopped ->
            Ok new

        _ ->
            Err "cannot reset a stopwatch that is not stopped"


parseTime : String -> Int
parseTime time =
    let
        timeValues =
            time
                |> String.split ":"
                |> List.filterMap String.toInt
    in
    case timeValues of
        [ hours, minutes, seconds ] ->
            hours * 3600 + minutes * 60 + seconds

        _ ->
            0


formatTime : Int -> String
formatTime time =
    let
        hours =
            time // 3600

        minutes =
            modBy 3600 time // 60

        seconds =
            modBy 60 time
    in
    [ hours, minutes, seconds ]
        |> List.map String.fromInt
        |> List.map (String.padLeft 2 '0')
        |> String.join ":"
