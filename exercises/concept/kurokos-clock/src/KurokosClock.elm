module KurokosClock exposing (Locale(..), showDateTime, showLocalDate, showLocalTime)

import Time exposing (Month(..), Posix, Zone)


type Locale
    = US
    | JP


showLocalDate : Locale -> Int -> Month -> Int -> String
showLocalDate locale year month day =
    Debug.todo "Please implement showLocalDate"


showLocalTime : Locale -> Int -> Int -> String
showLocalTime locale hour minute =
    Debug.todo "Please implement showLocalTime"


showDateTime : Locale -> Zone -> Posix -> String
showDateTime locale zone posix =
    Debug.todo "Please implement showDateTime"
