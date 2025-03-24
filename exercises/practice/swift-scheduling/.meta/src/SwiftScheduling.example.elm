module SwiftScheduling exposing (deliveryDate)

import Time exposing (Month(..), Posix, Weekday(..))


deliveryDate : Posix -> String -> Posix
deliveryDate meetingStart description =
    meetingStart
        |> toDateTime
        |> getDeliveryDate (parseDescription description)
        |> toPosix


getDeliveryDate : Description -> DateTime -> DateTime
getDeliveryDate description start =
    case description of
        Now ->
            { start | hour = start.hour + 2 }

        AsSoonAsPossible ->
            if start.hour < 13 then
                { start | hour = 17, minute = 0, second = 0 }

            else
                -- this can produce impossible dates, but it doesn't matter for the final Posix value
                { start | day = start.day + 1, hour = 13, minute = 0, second = 0 }

        EndOfWeek ->
            case start |> toPosix |> Time.toWeekday Time.utc of
                Mon ->
                    { start | day = start.day + 4, hour = 17, minute = 0, second = 0 }

                Tue ->
                    { start | day = start.day + 3, hour = 17, minute = 0, second = 0 }

                Wed ->
                    { start | day = start.day + 2, hour = 17, minute = 0, second = 0 }

                Thu ->
                    { start | day = start.day + 3, hour = 20, minute = 0, second = 0 }

                _ ->
                    { start | day = start.day + 2, hour = 20, minute = 0, second = 0 }

        Month month ->
            case compareMonths start.month month of
                LT ->
                    firstWorkDayAfterOrOn
                        { start | month = month, day = 1, hour = 8, minute = 0, second = 0 }

                _ ->
                    firstWorkDayAfterOrOn
                        { start | year = start.year + 1, month = month, day = 1, hour = 8, minute = 0, second = 0 }

        Quarter quarter ->
            case compare (toQuarter start.month) quarter of
                GT ->
                    { start | year = start.year + 1, hour = 8, minute = 0, second = 0 }
                        |> toEndOfQuarter quarter
                        |> lastWorkDayBeforeOrOn

                _ ->
                    { start | hour = 8, minute = 0, second = 0 }
                        |> toEndOfQuarter quarter
                        |> lastWorkDayBeforeOrOn



-- DESCRIPTION


type Description
    = Now
    | AsSoonAsPossible
    | EndOfWeek
    | Month Month
    | Quarter Int


parseDescription : String -> Description
parseDescription description =
    let
        split timing =
            String.replace timing "" >> String.toInt
    in
    case ( description, split "M" description, split "Q" description ) of
        ( _, Just n, _ ) ->
            Month (numberToMonth n)

        ( _, _, Just n ) ->
            Quarter n

        ( "ASAP", _, _ ) ->
            AsSoonAsPossible

        ( "EOW", _, _ ) ->
            EndOfWeek

        _ ->
            Now



-- DATETIME


type alias DateTime =
    { year : Int
    , month : Month
    , day : Int
    , hour : Int
    , minute : Int
    , second : Int
    }


toDateTime : Posix -> DateTime
toDateTime posix =
    DateTime (Time.toYear Time.utc posix)
        (Time.toMonth Time.utc posix)
        (Time.toDay Time.utc posix)
        (Time.toHour Time.utc posix)
        (Time.toMinute Time.utc posix)
        (Time.toSecond Time.utc posix)


toPosix : DateTime -> Posix
toPosix { year, month, day, hour, minute, second } =
    Time.millisToPosix
        (1000 * (dateToSecond year month day + hourToSecond hour + minuteToSecond minute + second))


dateToSecond : Int -> Month -> Int -> Int
dateToSecond year month day =
    let
        -- Posix 0 is Jan 1, 1970
        leapYearsSince1970 =
            leapYearsBefore year - leapYearsBefore 1970

        yearInSecond =
            dayToSecond (365 * (year - 1970) + leapYearsSince1970)

        monthInDays =
            case ( isLeapYear year, month ) of
                ( False, _ ) ->
                    daysBeforeMonthInNonLeapYear month

                ( True, Jan ) ->
                    daysBeforeMonthInNonLeapYear month

                ( True, Feb ) ->
                    daysBeforeMonthInNonLeapYear month

                ( True, _ ) ->
                    1 + daysBeforeMonthInNonLeapYear month
    in
    yearInSecond + dayToSecond monthInDays + dayToSecond (day - 1)


isLeapYear : Int -> Bool
isLeapYear year =
    if modBy 400 year == 0 then
        True

    else if modBy 100 year == 0 then
        False

    else
        modBy 4 year == 0


leapYearsBefore : Int -> Int
leapYearsBefore year =
    (year - 1) // 4 - (year - 1) // 100 + (year - 1) // 400


daysBeforeMonthInNonLeapYear : Month -> Int
daysBeforeMonthInNonLeapYear month =
    case month of
        Jan ->
            0

        Feb ->
            daysBeforeMonthInNonLeapYear Jan + 31

        Mar ->
            daysBeforeMonthInNonLeapYear Feb + 28

        Apr ->
            daysBeforeMonthInNonLeapYear Mar + 31

        May ->
            daysBeforeMonthInNonLeapYear Apr + 30

        Jun ->
            daysBeforeMonthInNonLeapYear May + 31

        Jul ->
            daysBeforeMonthInNonLeapYear Jun + 30

        Aug ->
            daysBeforeMonthInNonLeapYear Jul + 31

        Sep ->
            daysBeforeMonthInNonLeapYear Aug + 31

        Oct ->
            daysBeforeMonthInNonLeapYear Sep + 30

        Nov ->
            daysBeforeMonthInNonLeapYear Oct + 31

        Dec ->
            daysBeforeMonthInNonLeapYear Nov + 30


dayToSecond : Int -> Int
dayToSecond day =
    hourToSecond (day * 24)


hourToSecond : Int -> Int
hourToSecond hour =
    minuteToSecond (hour * 60)


minuteToSecond : Int -> Int
minuteToSecond minute =
    minute * 60


compareMonths : Month -> Month -> Order
compareMonths a b =
    compare (monthToNumber a) (monthToNumber b)


toQuarter : Month -> Int
toQuarter month =
    1 + (monthToNumber month - 1) // 3


toEndOfQuarter : Int -> DateTime -> DateTime
toEndOfQuarter quarter datetime =
    case quarter of
        1 ->
            { datetime | month = Mar, day = 31 }

        2 ->
            { datetime | month = Jun, day = 30 }

        3 ->
            { datetime | month = Sep, day = 30 }

        _ ->
            { datetime | month = Dec, day = 31 }


firstWorkDayAfterOrOn : DateTime -> DateTime
firstWorkDayAfterOrOn datetime =
    case datetime |> toPosix |> Time.toWeekday Time.utc of
        Sat ->
            { datetime | day = datetime.day + 2 }

        Sun ->
            { datetime | day = datetime.day + 1 }

        _ ->
            datetime


lastWorkDayBeforeOrOn : DateTime -> DateTime
lastWorkDayBeforeOrOn datetime =
    case datetime |> toPosix |> Time.toWeekday Time.utc of
        Sat ->
            { datetime | day = datetime.day - 1 }

        Sun ->
            { datetime | day = datetime.day - 2 }

        _ ->
            datetime


numberToMonth : Int -> Month
numberToMonth n =
    case n of
        1 ->
            Jan

        2 ->
            Feb

        3 ->
            Mar

        4 ->
            Apr

        5 ->
            May

        6 ->
            Jun

        7 ->
            Jul

        8 ->
            Aug

        9 ->
            Sep

        10 ->
            Oct

        11 ->
            Nov

        _ ->
            Dec


monthToNumber : Month -> Int
monthToNumber month =
    case month of
        Jan ->
            1

        Feb ->
            2

        Mar ->
            3

        Apr ->
            4

        May ->
            5

        Jun ->
            6

        Jul ->
            7

        Aug ->
            8

        Sep ->
            9

        Oct ->
            10

        Nov ->
            11

        Dec ->
            12
