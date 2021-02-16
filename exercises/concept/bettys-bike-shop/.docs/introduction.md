# Introduction

## Exporting functions

Exporting functions was covered in the basics concept, here is a quick refresher.

Each file in Elm is a module, and must contain a `module` statement before all other code.

Module names must match their file name, so module `Calculator` must be in file Calculator.elm, and module `Parser.Utils` needs to be in file Parser/Utils.elm.

Anything defined within a module is privatly scoped to it and cannot be accessed from outside this module, unless listed in `exposing`.

```elm
-- Define the Calculator module, and expose the `add` function
module Calculator exposing (add)

six = 3 + 3

add number1 number2 = number1 + number2
```

```elm
-- Define the Calculator module, and expose everything within: `six` and `add`
module Calculator exposing (..)

six = 3 + 3

add number1 number2 = number1 + number2
```

https://elm-lang.org/docs/syntax#modules

## Importing functions from other modules

Accessing functions defined in other modules is done via imports.
All functions within that module that were exposed by it are made accessible when importing that module.
But how they are accessed varies depending on how the module is imported.

Qualified imports are the default, and accessing a function within such module (for example the `map` function in the `List` module) is done by prefixing the module name (`List.map`).

Open imports enable direct access to the exposed functions within that module, without prefixing. They are done with the `exposing` keyword, like a mirror to the one used in exports. You can expose all available functions (with `..`), or specific ones (for example `map`).

You can also import types, and their constructors from other modules, which is a later concept.

Qualified imports are preferred to aid clarity and avoid name clashes.

```elm
-- qualified imports
import List                            -- List.map, List.foldl
import List as L                       -- L.map, L.foldl

-- open imports
import List exposing (..)              -- map, foldl, concat, ...
import List exposing ( map, foldl )    -- map, foldl
```

https://elm-lang.org/docs/syntax#modules

## Type annotations

Type Annotations are defined with `name : parameter types -> return type` , parameter types also being separated by `->`. 

```elm
add :  Int -> Int -> Int
add number1 number2 = number1 + number2
```

Parentheses can be used to define function parameters (which are themselves defined with the same syntax, hence the need for brackets).

```elm
-- Transform every character in a string
map : (Char -> Char) -> String -> String
map charMapperFunction string =
    --- ...
```

https://elm-lang.org/docs/syntax#type-annotations

## String operations

Elm has a native `String` type,  `++` string concatenation operator and `==` equality operator. These are always available.

Most other string functions are in the String module, which needs to be imported.

https://package.elm-lang.org/packages/elm/core/latest/String
