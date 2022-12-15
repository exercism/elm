# General

- Don't forget to expose all functions that are required by the tests

## 1. Define the Password opaque type, using the "Parse, don't validate" pattern

- The Elm guide has a section on [custom types][custom-types].
- The `Password` custom type only has a single variant.
- Idiomatically in Elm, when a custom type has a single variant, the variant and the type have the same name (in this case both would be called `Password`)
- The Elm guide has a section on [Maybe][maybe] if you need a refresher.

## 2. Expose SecureTreasureChest, but not it's variant

- The Elm guide has a section on [custom types][custom-types].
- The `SecureTreasureChest` custom type only has a single variant.
- Idiomatically in Elm, when a custom type has a single variant, the variant and the type have the same name (in this case both would be called `SecureTreasureChest`)

## 3. Define the createTreasure function

- There is a [shorthand for destructuring single member custom types][single-member-custom-destructuring].

## 4. Define the getTreasure function

- This is most easily done with an `if` expression
- The Elm guide has a section on [Maybe][maybe] if you need a refresher.

[custom-types][https://guide.elm-lang.org/types/custom_types.html]
[single-member-custom-destructuring][https://gist.github.com/yang-wei/4f563fbf81ff843e8b1e?permalink_comment_id=1701264#gistcomment-1701264]
[maybe][https://guide.elm-lang.org/error_handling/maybe.html]
