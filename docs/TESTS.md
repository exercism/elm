First, execute the following:
```bash
$ elm-reactor
```
Then go to `localhost:8000` in your browser and navigate to your test file.

## Making Your First Elm Module

To create a module that can be loaded with `import BobExample exposing (responseFor)`, put this code in `BobExample.elm`:

```elm
module BobExample where

responseFor : String -> String
responseFor statement = undefined
```
