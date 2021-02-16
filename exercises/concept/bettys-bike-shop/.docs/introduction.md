# Introduction

## Importing functions from other modules

There are various ways to import functions, as shown below.

Qualified imports always import all available functions from the module (for example `List`), and when using them, they must be prefixed with the module name (for example `List.map`).

Open imports can import all available functions (with `..`), or specific named functions (for eaxmple `map`). They do not require prefixing when used.

You can also import Type's, and their constructors from other modules, which is a later concept

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

## Exporting functions

Exporting functions was covered in the basics concept, but the concept is linked with importing functions, so a quick refresher is merited here.

Each file in Elm is a module, and must contain a `module` statement before all other code.

Module names must match their file name, so module `Calculator` must be in file Calculator.elm, and Parser.Utils needs to be in file Parser/Utils.elm.

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
