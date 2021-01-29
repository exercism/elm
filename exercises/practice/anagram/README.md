# Anagram

An anagram is a rearrangement of letters to form a new word.
Given a word and a list of candidates, select the sublist of anagrams of the given word.

Given `"listen"` and a list of candidates like `"enlists" "google"
"inlets" "banana"` the program should return a list containing
`"inlets"`.

## Elm Installation

Refer to the [Installing Elm](https://exercism.io/tracks/elm/installation) page
for information about installing elm.

## Writing the Code

The code you have to write is located inside the `src/` directory of the exercise.
Elm automatically installs packages dependencies the first time you run the tests
so we can start by running the tests from the exercise directory with:

```bash
$ elm-test
```

To automatically run tests again when you save changes:

```bash
$ elm-test --watch
```

As you work your way through the tests suite in the file `tests/Tests.elm`,
be sure to remove the `skip <|`
calls from each test until you get them all passing!

## Source

Inspired by the Extreme Startup game [https://github.com/rchatley/extreme_startup](https://github.com/rchatley/extreme_startup)

## Submitting Incomplete Solutions

It is possible to submit an incomplete solution so you can see how others have
completed the exercise.
