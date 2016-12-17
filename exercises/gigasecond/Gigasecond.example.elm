module Gigasecond exposing (add)

import Date
import Time


add : Date.Date -> Date.Date
add =
    Date.toTime >> (+) gigasecond >> Date.fromTime


gigasecond : Time.Time
gigasecond =
    10 ^ 12
