# Debug

You can use [Debug.log](https://package.elm-lang.org/packages/elm/core/latest/Debug#log) to attach messages to failing tests, like so:

```elm
preparationTimeInMinutes : Int -> Int
preparationTimeInMinutes numberOfLayers = 
    Debug.log "preparationTimeInMinutes" 2 * numberOfLayers
```

On a failing test, the attached log will be `preparationTimeInMinutes: 2`.

There is one caveat: top-level functions without parameters (constants) are evaluated only once before tests start running, therefore tests cannot capture their log messages. For example:

```elm
expectedMinutesInOven : Int
expectedMinutesInOven = 
    Debug.log "expectedMinutesInOven" 2 * 20
```

will not log anything during tests because the JavaScript variable associated to `expectedMinutesInOven` has already been evaluated to the value 40.
