# Debug

When a test fails, a message is displayed describing what went wrong and for which input. You can also use the fact that the tests will report any log output. You can write to the log using [Debug.log](https://package.elm-lang.org/packages/elm/core/latest/Debug#log)

There is a slight nuance in that log output for constants / functions without a parameter are essentially optimised out by the transpiler, and so are not captured.

In this case the function has a parameter so everything works as expected

```elm
preparationTimeInMinutes numberOfLayers = 
    Debug.log "preparationTimeInMinutes" 2 * numberOfLayers
```

In this case the function doesn't have a parameter (and so is essentially a constant, as functions are pure), and the log output is not captured.

```elm
expectedMinutesInOven = 
    Debug.log "expectedMinutesInOven" 40

```

