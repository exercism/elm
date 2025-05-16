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
    = TODO String


new : Stopwatch
new =
    TODO "Please implement new"


state : Stopwatch -> State
state stopwatch =
    Debug.todo "Please implement state"


currentLap : Stopwatch -> String
currentLap stopwatch =
    Debug.todo "Please implement currentLap"


previousLaps : Stopwatch -> List String
previousLaps stopwatch =
    Debug.todo "Please implement previousLaps"


advanceTime : String -> Stopwatch -> Stopwatch
advanceTime time stopwatch =
    Debug.todo "Please implement advanceTime"


total : Stopwatch -> String
total stopwatch =
    Debug.todo "Please implement total"


start : Stopwatch -> Result String Stopwatch
start stopwatch =
    Debug.todo "Please implement start"


stop : Stopwatch -> Result String Stopwatch
stop stopwatch =
    Debug.todo "Please implement stop"


lap : Stopwatch -> Result String Stopwatch
lap stopwatch =
    Debug.todo "Please implement lap"


reset : Stopwatch -> Result String Stopwatch
reset stopwatch =
    Debug.todo "Please implement reset"
