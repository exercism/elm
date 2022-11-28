# General

## 1. Define the TreasureChest generic custom type

- The Elm guide has a section on [custom types][custom-types].
- The `TreasureChest` custom type only has a single variant.
- Idiomatically in Elm, when a custom type has a single variant, the variant and the type have the same name (in this case both would be called `TreasureChest`)

## 2. Define the getTreasure function

- There is a [shorthand for destructuring single member custom types][single-member-custom-destructuring].
- The Elm guide has a section on [Maybe][maybe] if you need a refresher.

## 3. Define the multiplyTreasure function

- You can use round brackets to separate out the type definition for the multiplier function from the rest of the type definition for `multiplyTreasure`

[custom-types][https://guide.elm-lang.org/types/custom_types.html]
[single-member-custom-destructuring]: https://gist.github.com/yang-wei/4f563fbf81ff843e8b1e?permalink_comment_id=1701264#gistcomment-1701264
[maybe][https://guide.elm-lang.org/error_handling/maybe.html]
