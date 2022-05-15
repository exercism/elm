# Debug

You can use [Debug.log](https://package.elm-lang.org/packages/elm/core/latest/Debug#log) to attach messages to failing tests, like so:

```elm
hoursToSeconds : Int -> Int
hoursToSeconds hours =
    let
        secondsInOneHour =
            Debug.log "secondsInOneHour" (60 * 60)
    in
    hours * secondsInOneHour
```

On a failing test, the attached log will be `secondsInOneHour: 3600`.

There is one caveat: top-level constants are evaluated only once before tests start running, therefore tests cannot capture their log messages. For example:

```elm
secondsInOneHour : Int
secondsInOneHour =
    Debug.log "secondsInOneHour" (60 * 60)
```

will not log anything during tests because the JavaScript variable associated to `secondsInOneHour` has already been evaluated to the value 3600.
