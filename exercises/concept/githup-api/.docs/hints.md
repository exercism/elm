# Hints

## General

- Make sure to read the documentation for [decoders][decode] and [encoders][encode]
- The [GitHub documentation][github] that inspired this exercise contain more information about the JSON objects
- You should be able to use [`Decode.decodeString`][decode-decodeString] to test your decoders on arbitrary input

## 1. ID, please!

The task can be solved with the following functions:

- [`int`][decode-int]
- [`field`][decode-field]

## 2. What's my name again?

There are two main ways of solving the task:

- using [`maybe`][decode-maybe]
- using [`oneOf`][decode-oneOf] with two possible decoders, one using a combination of [`field`][decode-field], [`string`][decode-string] [`map`][decode-map], and one using [`succeed`][decode-succeed]

## 3. User? I hardly know her!

The task can be solved with the following functions:

- `decodeId` and `decodeName`
- `User` used as a type constructor
- [`map5`][decode-map5]
- [`field`][decode-field]
- [`int`][decode-int]
- [`string`][decode-string]
- [`bool`][decode-bool]

## 4. I'm a strong independent comment

The task can be solved with the following functions:

- [`field`][decode-field]
- [`int`][decode-int]
- [`nullable`][decode-nullable]

## 5. Side hustle

The task can be solved with the following functions:

- [`field`][decode-field]
- [`string`][decode-string]
- [`andThen`][decode-andThen]
- a case statement checking the content of the string being decoded
- [`succeed`][decode-succeed]
- [`fail`][decode-fail]

## 6. Links awakening

The task can be solved with the following functions:

- [`field`][decode-field]
- [`dict`][decode-dict]
- [`string`][decode-string]

## 7. Yes comments

`decodeComment` can be solved with the following functions:

- `decodeId`, `decodePullRequestReviewId`, `decodeUser`, `decodeSide`, `decodeLinks`
- `Comment` used as a type constructor
- [`6`][decode-6]
- [`field`][decode-field]
- [`string`][decode-string]

`decodeComments` can be solved with the following functions:

- `decodeComment`
- [`list`][decode-list]

## 8. It all ties together

All the functions required for this task are defines in [the documentation for encoders][encode], and potentially some from the [`Maybe` module][maybe]

[github]: https://docs.github.com/en/rest/pulls/comments?apiVersion=2022-11-28
[decode]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode
[decode-decodeString]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#decodeString
[decode-string]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#string
[decode-maybe]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#maybe
[decode-int]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#int
[decode-bool]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#bool
[decode-field]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#field
[decode-map]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#map
[decode-succeed]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#succeed
[decode-map5]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#map5
[decode-map6]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#map6
[decode-andThen]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#andThen
[decode-oneOf]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#oneOf
[decode-fail]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#fail
[decode-nullable]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#nullable
[decode-dict]: https://package.elm-lang.org/packages/elm/json/latest/Json-Decode#dict
[encode]: https://package.elm-lang.org/packages/elm/json/latest/Json-Encode
[maybe]: https://package.elm-lang.org/packages/elm/core/latest/Maybe
