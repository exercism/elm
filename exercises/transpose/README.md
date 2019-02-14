# Transpose

Given an input text output it transposed.

Roughly explained, the transpose of a matrix:

```text
ABC
DEF
```

is given by:

```text
AD
BE
CF
```

Rows become columns and columns become rows. See <https://en.wikipedia.org/wiki/Transpose>.

If the input has rows of different lengths, this is to be solved as follows:

- Pad to the left with spaces.
- Don't pad to the right.

Therefore, transposing this matrix:

```text
ABC
DE
```

results in:

```text
AD
BE
C
```

And transposing:

```text
AB
DEF
```

results in:

```text
AD
BE
 F
```

In general, all characters from the input should also be present in the transposed output.
That means that if a column in the input text contains only spaces on its bottom-most row(s),
the corresponding output row should contain the spaces in its right-most column(s).

## Elm Installation

Refer to the [Installing Elm](https://exercism.io/tracks/elm/installation) page
for information about installing elm.

## Writing the Code

The first time you start an exercise, you'll need to ensure you have the
appropriate dependencies installed. Thankfully, Elm makes that easy for you and
will install dependencies when you try to run tests or build the code.

Execute the tests with:

```bash
$ elm-test
```

Automatically run tests again when you save changes:

```bash
$ elm-test --watch
```

As you work your way through the test suite, be sure to remove the `skip <|`
calls from each test until you get them all passing!

## Source

Reddit r/dailyprogrammer challenge #270 [Easy]. [https://www.reddit.com/r/dailyprogrammer/comments/4msu2x/challenge_270_easy_transpose_the_input_text](https://www.reddit.com/r/dailyprogrammer/comments/4msu2x/challenge_270_easy_transpose_the_input_text)

## Submitting Incomplete Solutions

It is possible to submit an incomplete solution so you can see how others have
completed the exercise.
