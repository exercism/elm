# Hints

## General

- Check out the [`elm/time` documentation][elm-time] for working with dates and times
- The introduction showcases most of the necessary concepts to solve the exercise

## 1. It's a date

- The [`String.fromInt` function][fromInt] can convert numbers to strings
- You'll need to convert months to their numeric representation, consider creating a helper function
- For the Japanese locale, you can copy paste the characters from the instructions (年, 月, 日), the numbers should not be formatted in a Japanese encoding

## 2. It's show time

- The [`modBy` function][modBy] can help with hour conversion
- Use [`String.padLeft`][padLeft] to ensure minutes have leading zeros
- For the Japanese locale, you can copy paste the characters from the instructions (時, 分), the numbers should not be formatted in a Japanese encoding

## 3. Get in the zone

- [`Time.toYear`][toYear], [`Time.toMonth`][toMonth], [`Time.toDay`][toDay] can help get date parts
- [`Time.toHour`][toHour] and [`Time.toMinute`][toMinute] can help get time parts
- Combine the results from `showLocalDate` and `showLocalTime`

[elm-time]: https://package.elm-lang.org/packages/elm/time/latest/
[fromInt]: https://package.elm-lang.org/packages/elm/core/latest/String#fromInt
[modBy]: https://package.elm-lang.org/packages/elm/core/latest/Basics#modBy
[padLeft]: https://package.elm-lang.org/packages/elm/core/latest/String#padLeft
[toYear]: https://package.elm-lang.org/packages/elm/time/latest/Time#toYear
[toMonth]: https://package.elm-lang.org/packages/elm/time/latest/Time#toMonth
[toDay]: https://package.elm-lang.org/packages/elm/time/latest/Time#toDay
[toHour]: https://package.elm-lang.org/packages/elm/time/latest/Time#toHour
[toMinute]: https://package.elm-lang.org/packages/elm/time/latest/Time#toMinute
