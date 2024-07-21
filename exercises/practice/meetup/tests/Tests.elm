module Tests exposing (tests)

import Expect
import Meetup exposing (Month(..), Week(..), Weekday(..))
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Meetup"
        [ -- skip <|
          test "when teenth Monday is the 13th, the first day of the teenth week" <|
            \() ->
                Meetup.meetup 2013 May Teenth Monday
                    |> Expect.equal "2013-05-13"
        , skip <|
            test "when teenth Monday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 August Teenth Monday
                        |> Expect.equal "2013-08-19"
        , skip <|
            test "when teenth Monday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 September Teenth Monday
                        |> Expect.equal "2013-09-16"
        , skip <|
            test "when teenth Tuesday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 March Teenth Tuesday
                        |> Expect.equal "2013-03-19"
        , skip <|
            test "when teenth Tuesday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 April Teenth Tuesday
                        |> Expect.equal "2013-04-16"
        , skip <|
            test "when teenth Tuesday is the 13th, the first day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 August Teenth Tuesday
                        |> Expect.equal "2013-08-13"
        , skip <|
            test "when teenth Wednesday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 January Teenth Wednesday
                        |> Expect.equal "2013-01-16"
        , skip <|
            test "when teenth Wednesday is the 13th, the first day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 February Teenth Wednesday
                        |> Expect.equal "2013-02-13"
        , skip <|
            test "when teenth Wednesday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 June Teenth Wednesday
                        |> Expect.equal "2013-06-19"
        , skip <|
            test "when teenth Thursday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 May Teenth Thursday
                        |> Expect.equal "2013-05-16"
        , skip <|
            test "when teenth Thursday is the 13th, the first day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 June Teenth Thursday
                        |> Expect.equal "2013-06-13"
        , skip <|
            test "when teenth Thursday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 September Teenth Thursday
                        |> Expect.equal "2013-09-19"
        , skip <|
            test "when teenth Friday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 April Teenth Friday
                        |> Expect.equal "2013-04-19"
        , skip <|
            test "when teenth Friday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 August Teenth Friday
                        |> Expect.equal "2013-08-16"
        , skip <|
            test "when teenth Friday is the 13th, the first day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 September Teenth Friday
                        |> Expect.equal "2013-09-13"
        , skip <|
            test "when teenth Saturday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 February Teenth Saturday
                        |> Expect.equal "2013-02-16"
        , skip <|
            test "when teenth Saturday is the 13th, the first day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 April Teenth Saturday
                        |> Expect.equal "2013-04-13"
        , skip <|
            test "when teenth Saturday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 October Teenth Saturday
                        |> Expect.equal "2013-10-19"
        , skip <|
            test "when teenth Sunday is the 19th, the last day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 May Teenth Sunday
                        |> Expect.equal "2013-05-19"
        , skip <|
            test "when teenth Sunday is some day in the middle of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 June Teenth Sunday
                        |> Expect.equal "2013-06-16"
        , skip <|
            test "when teenth Sunday is the 13th, the first day of the teenth week" <|
                \() ->
                    Meetup.meetup 2013 October Teenth Sunday
                        |> Expect.equal "2013-10-13"
        , skip <|
            test "when first Monday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 March First Monday
                        |> Expect.equal "2013-03-04"
        , skip <|
            test "when first Monday is the 1st, the first day of the first week" <|
                \() ->
                    Meetup.meetup 2013 April First Monday
                        |> Expect.equal "2013-04-01"
        , skip <|
            test "when first Tuesday is the 7th, the last day of the first week" <|
                \() ->
                    Meetup.meetup 2013 May First Tuesday
                        |> Expect.equal "2013-05-07"
        , skip <|
            test "when first Tuesday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 June First Tuesday
                        |> Expect.equal "2013-06-04"
        , skip <|
            test "when first Wednesday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 July First Wednesday
                        |> Expect.equal "2013-07-03"
        , skip <|
            test "when first Wednesday is the 7th, the last day of the first week" <|
                \() ->
                    Meetup.meetup 2013 August First Wednesday
                        |> Expect.equal "2013-08-07"
        , skip <|
            test "when first Thursday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 September First Thursday
                        |> Expect.equal "2013-09-05"
        , skip <|
            test "when first Thursday is another day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 October First Thursday
                        |> Expect.equal "2013-10-03"
        , skip <|
            test "when first Friday is the 1st, the first day of the first week" <|
                \() ->
                    Meetup.meetup 2013 November First Friday
                        |> Expect.equal "2013-11-01"
        , skip <|
            test "when first Friday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 December First Friday
                        |> Expect.equal "2013-12-06"
        , skip <|
            test "when first Saturday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 January First Saturday
                        |> Expect.equal "2013-01-05"
        , skip <|
            test "when first Saturday is another day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 February First Saturday
                        |> Expect.equal "2013-02-02"
        , skip <|
            test "when first Sunday is some day in the middle of the first week" <|
                \() ->
                    Meetup.meetup 2013 March First Sunday
                        |> Expect.equal "2013-03-03"
        , skip <|
            test "when first Sunday is the 7th, the last day of the first week" <|
                \() ->
                    Meetup.meetup 2013 April First Sunday
                        |> Expect.equal "2013-04-07"
        , skip <|
            test "when second Monday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 March Second Monday
                        |> Expect.equal "2013-03-11"
        , skip <|
            test "when second Monday is the 8th, the first day of the second week" <|
                \() ->
                    Meetup.meetup 2013 April Second Monday
                        |> Expect.equal "2013-04-08"
        , skip <|
            test "when second Tuesday is the 14th, the last day of the second week" <|
                \() ->
                    Meetup.meetup 2013 May Second Tuesday
                        |> Expect.equal "2013-05-14"
        , skip <|
            test "when second Tuesday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 June Second Tuesday
                        |> Expect.equal "2013-06-11"
        , skip <|
            test "when second Wednesday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 July Second Wednesday
                        |> Expect.equal "2013-07-10"
        , skip <|
            test "when second Wednesday is the 14th, the last day of the second week" <|
                \() ->
                    Meetup.meetup 2013 August Second Wednesday
                        |> Expect.equal "2013-08-14"
        , skip <|
            test "when second Thursday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 September Second Thursday
                        |> Expect.equal "2013-09-12"
        , skip <|
            test "when second Thursday is another day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 October Second Thursday
                        |> Expect.equal "2013-10-10"
        , skip <|
            test "when second Friday is the 8th, the first day of the second week" <|
                \() ->
                    Meetup.meetup 2013 November Second Friday
                        |> Expect.equal "2013-11-08"
        , skip <|
            test "when second Friday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 December Second Friday
                        |> Expect.equal "2013-12-13"
        , skip <|
            test "when second Saturday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 January Second Saturday
                        |> Expect.equal "2013-01-12"
        , skip <|
            test "when second Saturday is another day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 February Second Saturday
                        |> Expect.equal "2013-02-09"
        , skip <|
            test "when second Sunday is some day in the middle of the second week" <|
                \() ->
                    Meetup.meetup 2013 March Second Sunday
                        |> Expect.equal "2013-03-10"
        , skip <|
            test "when second Sunday is the 14th, the last day of the second week" <|
                \() ->
                    Meetup.meetup 2013 April Second Sunday
                        |> Expect.equal "2013-04-14"
        , skip <|
            test "when third Monday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 March Third Monday
                        |> Expect.equal "2013-03-18"
        , skip <|
            test "when third Monday is the 15th, the first day of the third week" <|
                \() ->
                    Meetup.meetup 2013 April Third Monday
                        |> Expect.equal "2013-04-15"
        , skip <|
            test "when third Tuesday is the 21st, the last day of the third week" <|
                \() ->
                    Meetup.meetup 2013 May Third Tuesday
                        |> Expect.equal "2013-05-21"
        , skip <|
            test "when third Tuesday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 June Third Tuesday
                        |> Expect.equal "2013-06-18"
        , skip <|
            test "when third Wednesday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 July Third Wednesday
                        |> Expect.equal "2013-07-17"
        , skip <|
            test "when third Wednesday is the 21st, the last day of the third week" <|
                \() ->
                    Meetup.meetup 2013 August Third Wednesday
                        |> Expect.equal "2013-08-21"
        , skip <|
            test "when third Thursday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 September Third Thursday
                        |> Expect.equal "2013-09-19"
        , skip <|
            test "when third Thursday is another day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 October Third Thursday
                        |> Expect.equal "2013-10-17"
        , skip <|
            test "when third Friday is the 15th, the first day of the third week" <|
                \() ->
                    Meetup.meetup 2013 November Third Friday
                        |> Expect.equal "2013-11-15"
        , skip <|
            test "when third Friday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 December Third Friday
                        |> Expect.equal "2013-12-20"
        , skip <|
            test "when third Saturday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 January Third Saturday
                        |> Expect.equal "2013-01-19"
        , skip <|
            test "when third Saturday is another day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 February Third Saturday
                        |> Expect.equal "2013-02-16"
        , skip <|
            test "when third Sunday is some day in the middle of the third week" <|
                \() ->
                    Meetup.meetup 2013 March Third Sunday
                        |> Expect.equal "2013-03-17"
        , skip <|
            test "when third Sunday is the 21st, the last day of the third week" <|
                \() ->
                    Meetup.meetup 2013 April Third Sunday
                        |> Expect.equal "2013-04-21"
        , skip <|
            test "when fourth Monday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 March Fourth Monday
                        |> Expect.equal "2013-03-25"
        , skip <|
            test "when fourth Monday is the 22nd, the first day of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 April Fourth Monday
                        |> Expect.equal "2013-04-22"
        , skip <|
            test "when fourth Tuesday is the 28th, the last day of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 May Fourth Tuesday
                        |> Expect.equal "2013-05-28"
        , skip <|
            test "when fourth Tuesday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 June Fourth Tuesday
                        |> Expect.equal "2013-06-25"
        , skip <|
            test "when fourth Wednesday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 July Fourth Wednesday
                        |> Expect.equal "2013-07-24"
        , skip <|
            test "when fourth Wednesday is the 28th, the last day of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 August Fourth Wednesday
                        |> Expect.equal "2013-08-28"
        , skip <|
            test "when fourth Thursday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 September Fourth Thursday
                        |> Expect.equal "2013-09-26"
        , skip <|
            test "when fourth Thursday is another day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 October Fourth Thursday
                        |> Expect.equal "2013-10-24"
        , skip <|
            test "when fourth Friday is the 22nd, the first day of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 November Fourth Friday
                        |> Expect.equal "2013-11-22"
        , skip <|
            test "when fourth Friday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 December Fourth Friday
                        |> Expect.equal "2013-12-27"
        , skip <|
            test "when fourth Saturday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 January Fourth Saturday
                        |> Expect.equal "2013-01-26"
        , skip <|
            test "when fourth Saturday is another day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 February Fourth Saturday
                        |> Expect.equal "2013-02-23"
        , skip <|
            test "when fourth Sunday is some day in the middle of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 March Fourth Sunday
                        |> Expect.equal "2013-03-24"
        , skip <|
            test "when fourth Sunday is the 28th, the last day of the fourth week" <|
                \() ->
                    Meetup.meetup 2013 April Fourth Sunday
                        |> Expect.equal "2013-04-28"
        , skip <|
            test "last Monday in a month with four Mondays" <|
                \() ->
                    Meetup.meetup 2013 March Last Monday
                        |> Expect.equal "2013-03-25"
        , skip <|
            test "last Monday in a month with five Mondays" <|
                \() ->
                    Meetup.meetup 2013 April Last Monday
                        |> Expect.equal "2013-04-29"
        , skip <|
            test "last Tuesday in a month with four Tuesdays" <|
                \() ->
                    Meetup.meetup 2013 May Last Tuesday
                        |> Expect.equal "2013-05-28"
        , skip <|
            test "last Tuesday in another month with four Tuesdays" <|
                \() ->
                    Meetup.meetup 2013 June Last Tuesday
                        |> Expect.equal "2013-06-25"
        , skip <|
            test "last Wednesday in a month with five Wednesdays" <|
                \() ->
                    Meetup.meetup 2013 July Last Wednesday
                        |> Expect.equal "2013-07-31"
        , skip <|
            test "last Wednesday in a month with four Wednesdays" <|
                \() ->
                    Meetup.meetup 2013 August Last Wednesday
                        |> Expect.equal "2013-08-28"
        , skip <|
            test "last Thursday in a month with four Thursdays" <|
                \() ->
                    Meetup.meetup 2013 September Last Thursday
                        |> Expect.equal "2013-09-26"
        , skip <|
            test "last Thursday in a month with five Thursdays" <|
                \() ->
                    Meetup.meetup 2013 October Last Thursday
                        |> Expect.equal "2013-10-31"
        , skip <|
            test "last Friday in a month with five Fridays" <|
                \() ->
                    Meetup.meetup 2013 November Last Friday
                        |> Expect.equal "2013-11-29"
        , skip <|
            test "last Friday in a month with four Fridays" <|
                \() ->
                    Meetup.meetup 2013 December Last Friday
                        |> Expect.equal "2013-12-27"
        , skip <|
            test "last Saturday in a month with four Saturdays" <|
                \() ->
                    Meetup.meetup 2013 January Last Saturday
                        |> Expect.equal "2013-01-26"
        , skip <|
            test "last Saturday in another month with four Saturdays" <|
                \() ->
                    Meetup.meetup 2013 February Last Saturday
                        |> Expect.equal "2013-02-23"
        , skip <|
            test "last Sunday in a month with five Sundays" <|
                \() ->
                    Meetup.meetup 2013 March Last Sunday
                        |> Expect.equal "2013-03-31"
        , skip <|
            test "last Sunday in a month with four Sundays" <|
                \() ->
                    Meetup.meetup 2013 April Last Sunday
                        |> Expect.equal "2013-04-28"
        , skip <|
            test "when last Wednesday in February in a leap year is the 29th" <|
                \() ->
                    Meetup.meetup 2012 February Last Wednesday
                        |> Expect.equal "2012-02-29"
        , skip <|
            test "last Wednesday in December that is also the last day of the year" <|
                \() ->
                    Meetup.meetup 2014 December Last Wednesday
                        |> Expect.equal "2014-12-31"
        , skip <|
            test "when last Sunday in February in a non-leap year is not the 29th" <|
                \() ->
                    Meetup.meetup 2015 February Last Sunday
                        |> Expect.equal "2015-02-22"
        , skip <|
            test "when first Friday is the 7th, the last day of the first week" <|
                \() ->
                    Meetup.meetup 2012 December First Friday
                        |> Expect.equal "2012-12-07"
        ]
