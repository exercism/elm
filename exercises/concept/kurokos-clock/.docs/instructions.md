# Instructions

Your Japanese friend Kuroko is a streamer with an international appeal.
Kuroko's streaming schedule is pretty intricate, each stream seemingly starts at a different time every day.

He asks for your help in building a small application that will display his schedule in his viewers' local time zones: Kuroko's Clock.
He has an additional requirement: the app should be able to display the time in two different languages: Japanese and US English.

## 1. It's a date

Define a function `showLocalDate : Locale -> Int -> Month -> Int -> String` which will display a (valid) local date.

In the `US` locale, the format will be `M/D/Y`, while in the `JP` locale it will be `Y年M月D日`.

```elm
showLocalDate US 2025 May 1
    -- "5/1/2025"
showLocalDate JP 2025 May 1
    -- "2025年5月1日"
```

## 2. It's show time

Define a function `showLocalTime : Locale -> Int -> Int -> String` which will display a (valid) local time.

In the `US` locale, the hours will be shown in 12-hour notation along with "PM" or "AM", and the minutes will be shown with leading zeros.

In the `JP` locale, the hour will be shown in 24-hour notation before "時" and the minutes will be shown without leading zeros before "分".

```elm
showLocalTime US 13 8
    -- "1:08 PM"
showLocalTime JP 13 8
    -- "13時8分"
```

## 3. Get in the zone

Define a function `showDateTime : Locale -> Zone -> Posix -> String` which will display a date and time relative to a time zone in a specific locale.

Use `showLocalDate` and `showLocalTime` to display the final result.

```elm
showDateTime US Time.utc (Time.millisToPosix 0)
    -- "1/1/1970 12:00 AM"
showDateTime JP Time.utc (Time.millisToPosix 0)
    -- "1970年1月1日0時0分"
```
