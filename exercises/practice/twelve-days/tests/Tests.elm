module Tests exposing (tests)

import Expect
import Test exposing (..)
import TwelveDays


tests : Test
tests =
    describe "Twelve Days"
        [ test "first day a partridge in a pear tree" <|
            \() ->
                Expect.equal
                    [ "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
                    ]
                    (TwelveDays.recite 1 1)
        , skip <|
            test "second day two turtle doves" <|
                \() ->
                    Expect.equal
                        [ "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 2 2)
        , skip <|
            test "third day three french hens" <|
                \() ->
                    Expect.equal
                        [ "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 3 3)
        , skip <|
            test "fourth day four calling birds" <|
                \() ->
                    Expect.equal
                        [ "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 4 4)
        , skip <|
            test "fifth day five gold rings" <|
                \() ->
                    Expect.equal
                        [ "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 5 5)
        , skip <|
            test "sixth day six geese-a-laying" <|
                \() ->
                    Expect.equal
                        [ "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 6 6)
        , skip <|
            test "seventh day seven swans-a-swimming" <|
                \() ->
                    Expect.equal
                        [ "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 7 7)
        , skip <|
            test "eighth day eight maids-a-milking" <|
                \() ->
                    Expect.equal
                        [ "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 8 8)
        , skip <|
            test "ninth day nine ladies dancing" <|
                \() ->
                    Expect.equal
                        [ "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 9 9)
        , skip <|
            test "tenth day ten lords-a-leaping" <|
                \() ->
                    Expect.equal
                        [ "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 10 10)
        , skip <|
            test "eleventh day eleven pipers piping" <|
                \() ->
                    Expect.equal
                        [ "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 11 11)
        , skip <|
            test "twelfth day twelve drummers drumming" <|
                \() ->
                    Expect.equal
                        [ "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 12 12)
        , skip <|
            test "recites first three verses of the song" <|
                \() ->
                    Expect.equal
                        [ "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
                        , "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 1 3)
        , skip <|
            test "recites three verses from the middle of the song" <|
                \() ->
                    Expect.equal
                        [ "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 4 6)
        , skip <|
            test "recites the whole song" <|
                \() ->
                    Expect.equal
                        [ "On the first day of Christmas my true love gave to me: a Partridge in a Pear Tree."
                        , "On the second day of Christmas my true love gave to me: two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the third day of Christmas my true love gave to me: three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the fourth day of Christmas my true love gave to me: four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the fifth day of Christmas my true love gave to me: five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the sixth day of Christmas my true love gave to me: six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the seventh day of Christmas my true love gave to me: seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the eighth day of Christmas my true love gave to me: eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the ninth day of Christmas my true love gave to me: nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the tenth day of Christmas my true love gave to me: ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the eleventh day of Christmas my true love gave to me: eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        , "On the twelfth day of Christmas my true love gave to me: twelve Drummers Drumming, eleven Pipers Piping, ten Lords-a-Leaping, nine Ladies Dancing, eight Maids-a-Milking, seven Swans-a-Swimming, six Geese-a-Laying, five Gold Rings, four Calling Birds, three French Hens, two Turtle Doves, and a Partridge in a Pear Tree."
                        ]
                        (TwelveDays.recite 1 12)
        ]
