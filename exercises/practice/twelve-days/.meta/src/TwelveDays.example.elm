module TwelveDays exposing (recite)


recite : Int -> Int -> List String
recite start stop =
    List.map lyric (List.range start stop)


lyric : Int -> String
lyric day =
    let
        beginning =
            verseBegin day

        ending =
            if day == 1 then
                gift day

            else
                verseEnd day day
    in
    String.concat [ beginning, ending, "." ]


verseBegin : Int -> String
verseBegin day =
    String.concat
        [ "On the "
        , dayStr day
        , " day of Christmas my true love gave to me: "
        ]


verseEnd : Int -> Int -> String
verseEnd day originalDay =
    let
        dayGift =
            if day == originalDay then
                gift day

            else
                String.concat [ ", ", gift day ]
    in
    case day of
        1 ->
            String.concat [ ", and ", gift day ]

        _ ->
            String.concat [ dayGift, verseEnd (day - 1) originalDay ]


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

        _ ->
            "twelfth"


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

        _ ->
            "twelve Drummers Drumming"
