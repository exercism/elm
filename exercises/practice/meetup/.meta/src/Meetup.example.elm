module Meetup exposing (Month(..), Week(..), Weekday(..), meetup)


type Month
    = January
    | February
    | March
    | April
    | May
    | June
    | July
    | August
    | September
    | October
    | November
    | December


type Weekday
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday


type Week
    = First
    | Second
    | Third
    | Fourth
    | Last
    | Teenth


meetup : Int -> Month -> Week -> Weekday -> String
meetup year month week weekday =
    let
        firstOfMonth =
            dateToWeekday year month 1

        firstWeekdayOfMonth =
            1 + modBy 7 (weekdayToInt weekday - firstOfMonth)

        dayOfMonth =
            case week of
                First ->
                    firstWeekdayOfMonth

                Second ->
                    7 + firstWeekdayOfMonth

                Third ->
                    14 + firstWeekdayOfMonth

                Fourth ->
                    21 + firstWeekdayOfMonth

                Teenth ->
                    if firstWeekdayOfMonth >= 6 then
                        7 + firstWeekdayOfMonth

                    else
                        14 + firstWeekdayOfMonth

                Last ->
                    if 28 + firstWeekdayOfMonth <= getDaysInMonth year month then
                        28 + firstWeekdayOfMonth

                    else
                        21 + firstWeekdayOfMonth
    in
    [ String.fromInt year
    , printMonthNumber month
    , dayOfMonth |> String.fromInt |> String.padLeft 2 '0'
    ]
        |> String.join "-"


{-| Sakamoto's method

<https://en.wikipedia.org/wiki/Determination_of_the_day_of_the_week#Sakamoto's_methods>
Returns the weeday of a given date with 0 = Sunday, 1 = Monday...
valid for year > 1752 (in the U.K.)

-}
dateToWeekday : Int -> Month -> Int -> Int
dateToWeekday year month day =
    let
        y =
            sakamotoYear year month
    in
    modBy 7 (y + y // 4 - y // 100 + y // 400 + sakamotoMagicValue month + day)


sakamotoYear : Int -> Month -> Int
sakamotoYear year month =
    case month of
        January ->
            year - 1

        February ->
            year - 1

        _ ->
            year


sakamotoMagicValue : Month -> Int
sakamotoMagicValue month =
    case month of
        January ->
            0

        February ->
            3

        March ->
            2

        April ->
            5

        May ->
            0

        June ->
            3

        July ->
            5

        August ->
            1

        September ->
            4

        October ->
            6

        November ->
            2

        December ->
            4


weekdayToInt : Weekday -> Int
weekdayToInt weekday =
    case weekday of
        Sunday ->
            0

        Monday ->
            1

        Tuesday ->
            2

        Wednesday ->
            3

        Thursday ->
            4

        Friday ->
            5

        Saturday ->
            6


printMonthNumber : Month -> String
printMonthNumber month =
    case month of
        January ->
            "01"

        February ->
            "02"

        March ->
            "03"

        April ->
            "04"

        May ->
            "05"

        June ->
            "06"

        July ->
            "07"

        August ->
            "08"

        September ->
            "09"

        October ->
            "10"

        November ->
            "11"

        December ->
            "12"


getDaysInMonth : Int -> Month -> Int
getDaysInMonth year month =
    case month of
        February ->
            if isLeapYear year then
                29

            else
                28

        January ->
            31

        March ->
            31

        May ->
            31

        July ->
            31

        August ->
            31

        October ->
            31

        December ->
            31

        _ ->
            30


isLeapYear : Int -> Bool
isLeapYear year =
    modBy 400 year == 0 || (modBy 400 year /= 0 && modBy 4 year == 0)
