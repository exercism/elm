module TwelveDays exposing (recite)

import List exposing (map, range)
import String exposing (concat)


recite : Int -> Int -> List String
recite start stop =
    if withinSong start stop then
        map lyric (range start stop)

    else
        Debug.crash "I would make up verses if I could...sorry about this"


lyric : Int -> String
lyric day =
    let
        beginning =
            verseBegin day

        ending =
            if day == 1 then
                concat [ ", ", gift day ]

            else
                verseEnd day
    in
    concat [ beginning, ending, "." ]


verseBegin : Int -> String
verseBegin day =
    concat
        [ "On the "
        , dayStr day
        , " day of Christmas my true love gave to me"
        ]


verseEnd : Int -> String
verseEnd day =
    let
        dayGift =
            concat [ ", ", gift day ]
    in
    case day of
        1 ->
            concat [ ", and ", gift day ]

        _ ->
            concat [ dayGift, verseEnd (day - 1) ]


dayStr : Int -> String
dayStr day =
    case day of
        1 ->
            "first"

        2 ->
            "second"

        3 ->
            "third"

        4 ->
            "fourth"

        5 ->
            "fifth"

        6 ->
            "sixth"

        7 ->
            "seventh"

        8 ->
            "eighth"

        9 ->
            "ninth"

        10 ->
            "tenth"

        11 ->
            "eleventh"

        12 ->
            "twelfth"

        _ ->
            Debug.crash "Um, that's not a day I recognize...sorry"


gift : Int -> String
gift day =
    case day of
        1 ->
            "a Partridge in a Pear Tree"

        2 ->
            "two Turtle Doves"

        3 ->
            "three French Hens"

        4 ->
            "four Calling Birds"

        5 ->
            "five Gold Rings"

        6 ->
            "six Geese-a-Laying"

        7 ->
            "seven Swans-a-Swimming"

        8 ->
            "eight Maids-a-Milking"

        9 ->
            "nine Ladies Dancing"

        10 ->
            "ten Lords-a-Leaping"

        11 ->
            "eleven Pipers Piping"

        12 ->
            "twelve Drummers Drumming"

        _ ->
            Debug.crash "I don't have a gift for you...sorry"


withinSong : Int -> Int -> Bool
withinSong start stop =
    let
        goodStart =
            start >= 1 && start <= 12

        goodStop =
            stop >= 1 && start <= 12
    in
    start <= stop && goodStart && goodStop
