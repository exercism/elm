Run tests with soemthing like the following command:
```bash
$ elm-test exercises/bob/BobTests.elm
```

## Making Your First Elm Module

To create a module that can be loaded with `import BobExample exposing (responseFor)`, put this code in `BobExample.elm`:

```elm
module BobExample where

responseFor : String -> String
responseFor statement = undefined
```
