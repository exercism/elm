# Hints

## General

- Check out the [Elm Guide][elm-guide], which has a nice worked example that is similar.

## 1. Define the Model and Msg types for the application, and write the init function

- The `Model` contains the application's state - all the data that the application needs.
- It should be a [record][record].
- This application just needs a `String` to store the text in the text box (the tests require it to be called `content`).

- The `Msg` type defines the messages that are passed to the `update` function, to trigger specific changes in the model.
- It should be a [custom type][custom-type].
- This application only needs one change to the model - updating the model when the text in the text box changes.

- The `init` function should simply return a `Model` with sensible a default value (the tests require an empty string).

## 2. Write the update function

- In any useful application the update function will use a `case` statement to pattern match on the `Msg` parameter.
- In each branch of the case statement it will extract information it needs from the `Msg` parameter and return an updated `Model`
- The `Model` should be a record, and [record update syntax][record-update-syntax] is normally used.

## 3. Write the view function

- The `view` function should return a `div` for the root element
- The first child should be an `input`, with a `value` attribute for the current text, and an `onInput` attribute / event with the relevant variant of the `Msg`.
- The second child should be another `div` with a `text` child stating whether the text is a palindrome or not.

## 4. Write the main function

- The main function should just call [`Browser.sandbox`][browser-sandbox]
- `Browser.sandbox` requires a [record][record] argument with the `init`, `update` and `view` functions.

[elm-guide]: https://guide.elm-lang.org/architecture/text_fields
[record]: https://elm-lang.org/docs/records
[custom-type]: https://guide.elm-lang.org/types/custom_types.html
[record-update-syntax]: https://elm-lang.org/docs/records#updating-records
[browser-sandbox]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#sandbox
