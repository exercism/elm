# Instructions

Your friend Paula is trying to get better at solving crossword clues. She has read that [some clues show that the answer is a palindrome][palindrome-crossword-clues].
A palindrome is a word or sentence that reads the same backards as forwards.

She asks you write her a very simple website that will check whether a string is a palindrome (or not) so that she can check her guesses.

You decide to do this using an Elm [sandbox][browser-sandox] application.

The application will have a text box, that Paula can type her guess into, and text stating whether or not the text in the box is a palindrome.
The text will update whenever the text in the text box changes.

## 1. Define the Model and Msg types for the application, and write the init function

The application `Model` needs the string to check, this field should be called `content`.

The application needs a `Msg` to indicate that the text in the Text Box has changed.
The variant for this should be called `Change`

The `init` function should return a initial `Model` value with an empty `content` field.

## 2. Write the update function

The update function should take a `Msg` and a `Model` parameter, and return a new `Model`.

## 3. Write the view function

Elm requires that the view function has to return an `Html msg` type, which means that you need to return a single element from the view function (and not an  array of elements).

Inside this root element, there should be an `input` element (the Text Box), and a `div` with `text` content to state whether the text in the `input` is a palindrome or not.

The text should be "This is a palindrome" or "Not a palindrome".

## 4. Write the main function

The `main` function should call [`Browser.sandbox`][browser-sandbox], passing a record parameter with the `init`, `update` and `view` functions.

[palindrome-crossword-clues]: https://www.theguardian.com/crosswords/crossword-blog/2012/nov/01/cryptic-crosswords-beginners-palindromes
[browser-sandbox]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#sandbox
