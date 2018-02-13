module Say exposing (SayError(..), say)

import Array
import Dict


type SayError
    = Negative
    | TooLarge


say : Int -> Result SayError String
say number =
    if number < 0 then
        Err Negative
    else if number < 20 then
        Ok (saySmall number)
    else if number < 100 then
        if number % 10 == 0 then
            Ok (saySmall number)
        else
            Ok (sayTens (number // 10 * 10) ++ "-" ++ saySmall (number % 10))
    else if number < 1000 then
        Ok (sayLarge number 100 "hundred")
    else if number < million then
        Ok (sayLarge number 1000 "thousand")
    else if number < billion then
        Ok (sayLarge number million "million")
    else if number < trillion then
        Ok (sayLarge number billion "billion")
    else if number < quintillion then
        Ok (sayLarge number trillion "trillion")
    else
        Err TooLarge


safeSay : Int -> String
safeSay number =
    say number |> Result.withDefault ""


andSay : Int -> String
andSay number =
    if number < 100 then
        "and " ++ safeSay number
    else
        safeSay number


saySmall : Int -> String
saySmall number =
    Array.get number smalls |> Maybe.withDefault ""


sayTens : Int -> String
sayTens number =
    Dict.get number tens |> Maybe.withDefault ""


sayLarge : Int -> Int -> String -> String
sayLarge number large name =
    if number % large == 0 then
        safeSay (number // large) ++ " " ++ name
    else
        safeSay (number // large) ++ " " ++ name ++ " " ++ andSay (number % large)


smalls : Array.Array String
smalls =
    Array.fromList
        [ "zero"
        , "one"
        , "two"
        , "three"
        , "four"
        , "five"
        , "six"
        , "seven"
        , "eight"
        , "nine"
        , "ten"
        , "eleven"
        , "twelve"
        , "thirteen"
        , "fourteen"
        , "fifteen"
        , "sixteen"
        , "seventeen"
        , "eighteen"
        , "nineteen"
        , "twenty"
        ]


tens : Dict.Dict Int String
tens =
    Dict.fromList
        [ ( 20, "twenty" )
        , ( 30, "thirty" )
        , ( 40, "forty" )
        , ( 50, "fifty" )
        , ( 60, "sixty" )
        , ( 70, "seventy" )
        , ( 80, "eighty" )
        , ( 90, "ninety" )
        ]


million : Int
million =
    1000000


billion : Int
billion =
    1000000000


trillion : Int
trillion =
    1000000000000


quintillion : Int
quintillion =
    1000000000000000
