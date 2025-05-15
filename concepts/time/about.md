# About

The `Time` module is used to display human-readable dates / times.
While it's technically possibly to manipulate times with `Time`, there are Elm community packages that are far more suited to the task.

## Posix

Times are represented by the opaque type `Posix`, which wraps Unix epoch time, the number of milliseconds passed since January 1st, 1970 at midnight UTC.
A `Posix` is an non-ambiguous value that does not vary between time zones, therefore a good choice for keeping time.
In an Elm application, `Posix` times will typically be provided by external sources, such as the browser.

It is possible to transform a `Posix` into a number of millisecond and vice-versa with the following functions:

```elm
posixToMillis : Posix -> Int
millisToPosix : Int -> Posix
```

## Time Zones

In our day-to-day lives, we humans usually don't read `Posix` and instead prefer local time, which depends on our location on Earth, and local daylight-saving rules.
In Elm, this information is encoded in the opaque type `Zone`, usually provided by the browser.

There is a special `Zone` that is always accessible:

```elm
utc : Zone
```

## Human times

With a `Posix` and a `Zone`, we have enough information to show local time in any level of details.
Here is a list of the functions that can be used for that:

```elm
toYear : Zone -> Posix -> Int
toMonth : Zone -> Posix -> Month
toDay : Zone -> Posix -> Int
toWeekday : Zone -> Posix -> Weekday
toHour : Zone -> Posix -> Int
toMinute : Zone -> Posix -> Int
toSecond : Zone -> Posix -> Int
toMillis : Zone -> Posix -> Int
```

You will have spotted two more `Time` custom types:

```elm
type Month = Jan | Feb | Mar | Apr | May | Jun | Jul | Aug | Sep | Oct | Nov | Dec
type Weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun
```

It is left to users to convert these custom types to human-readable values.
