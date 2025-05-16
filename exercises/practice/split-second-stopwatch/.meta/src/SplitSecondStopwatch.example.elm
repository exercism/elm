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
        { aState : State
        , aCurrentLap : Int
        , aPreviousLaps : List Int
        }


new : Stopwatch
new =
    Stopwatch { aState = Ready, aCurrentLap = 0, aPreviousLaps = [] }


state : Stopwatch -> State
state (Stopwatch { aState }) =
    aState


currentLap : Stopwatch -> String
currentLap (Stopwatch { aCurrentLap }) =
    formatTime aCurrentLap


previousLaps : Stopwatch -> List String
previousLaps (Stopwatch { aPreviousLaps }) =
    aPreviousLaps
        |> List.reverse
        |> List.map formatTime


advanceTime : String -> Stopwatch -> Stopwatch
advanceTime time (Stopwatch ({ aState, aCurrentLap } as stopwatch)) =
    case aState of
        Running ->
            Stopwatch { stopwatch | aCurrentLap = aCurrentLap + parseTime time }

        _ ->
            Stopwatch stopwatch


total : Stopwatch -> String
total (Stopwatch { aCurrentLap, aPreviousLaps }) =
    (aCurrentLap :: aPreviousLaps)
        |> List.sum
        |> formatTime


start : Stopwatch -> Result String Stopwatch
start (Stopwatch ({ aState } as stopwatch)) =
    case aState of
        Running ->
            Err "cannot start an already running stopwatch"

        _ ->
            Ok (Stopwatch { stopwatch | aState = Running })


stop : Stopwatch -> Result String Stopwatch
stop (Stopwatch ({ aState } as stopwatch)) =
    case aState of
        Running ->
            Ok (Stopwatch { stopwatch | aState = Stopped })

        _ ->
            Err "cannot stop a stopwatch that is not running"


lap : Stopwatch -> Result String Stopwatch
lap (Stopwatch ({ aState, aCurrentLap, aPreviousLaps } as stopwatch)) =
    case aState of
        Running ->
            Ok (Stopwatch { stopwatch | aCurrentLap = 0, aPreviousLaps = aCurrentLap :: aPreviousLaps })

        _ ->
            Err "cannot lap a stopwatch that is not running"


reset : Stopwatch -> Result String Stopwatch
reset (Stopwatch { aState }) =
    case aState of
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
