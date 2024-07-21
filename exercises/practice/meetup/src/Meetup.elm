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
    Debug.todo "Please implement meetup"
