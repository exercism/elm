# Space Age

Given an age in seconds, calculate how old someone would be on:

   - Mercury: orbital period 0.2408467 Earth years
   - Venus: orbital period 0.61519726 Earth years
   - Earth: orbital period 1.0 Earth years, 365.25 Earth days, or 31557600 seconds
   - Mars: orbital period 1.8808158 Earth years
   - Jupiter: orbital period 11.862615 Earth years
   - Saturn: orbital period 29.447498 Earth years
   - Uranus: orbital period 84.016846 Earth years
   - Neptune: orbital period 164.79132 Earth years

So if you were told someone were 1,000,000,000 seconds old, you should
be able to say that they're 31.69 Earth-years old.

If you're wondering why Pluto didn't make the cut, go watch [this
youtube video](http://www.youtube.com/watch?v=Z_2gbGXzFbs).

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

Partially inspired by Chapter 1 in Chris Pine's online Learn to Program tutorial. [http://pine.fm/LearnToProgram/?Chapter=01](http://pine.fm/LearnToProgram/?Chapter=01)

## Submitting Incomplete Solutions

It is possible to submit an incomplete solution so you can see how others have
completed the exercise.
