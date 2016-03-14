# xElm
![build status](https://travis-ci.org/exercism/xelm.svg?branch=master)

Exercism Exercises in Elm

## Setup

Detailed installation instructions can be found at [http://elm-lang.org/install](http://elm-lang.org/install).

## Contributing

Thank you so much for contributing! :tada:

Please start by reading the general Exercism [contributing guide](https://github.com/exercism/x-api/blob/master/CONTRIBUTING.md#the-exercise-data).

We welcome pull requests that provide fixes and improvements to existing exercises. If you're unsure, then go ahead and open a GitHub issue, and we'll discuss the change.

Please keep the following in mind:

- Pull requests should be focused on a single exercise, issue, or change.

- We welcome changes to code style, and wording. Please open a separate PR for these changes if possible.

- Please open an issue before creating a PR that makes significant (breaking) changes to an existing exercise or makes changes across many exercises. It is best to discuss these changes before doing the work.

- Follow the coding standards found in [The Elm Style Guide](http://elm-lang.org/docs/style-guide). Please consider running [elm-format](https://github.com/avh4/elm-format) before submitting a pull request.

- Watch out for trailing spaces, extra blank lines, and spaces in blank lines.

- Each exercise must stand on its own. Do not reference files outside the exercise directory. They will not be included when the user fetches the exercise.

- Exercises should use only the Elm core libraries.

- Please do not add a README or README.md file to the exercise directory. The READMEs are constructed using shared metadata, which lives in the
[exercism/x-common](https://github.com/exercism/x-common) repository.

- Each exercise should have a test suite, an example solution, a template file for the real implementation and an `elm-package.json` file with the `elm-test` and `elm-console` dependencies. The CI build expects files to be named using the following convention. The example solution should be named `ExerciseModuleName.example`. The template file should be named `ExerciseModuleName.elm`. Test file should be named `ExerciseModuleNameTest.elm`.

- Test files should use the following format:

```elm
import Task
import Console
import ElmTest exposing (..)


tests : Test
tests =
  suite "ExerciseModuleName"
    [ test "first test" (assertEqual True True)
    , test "second test" (assertEqual False False)
    ]


port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)
```

 - All the tests for xElm exercises can be run from the top level of the repo with `bin/build.sh`. Please run this command before submitting your PR.

 - If you are submitting a new exercise, be sure to add it to the appropriate place in the `config.json` and `elm-package.json` files. Also, please run `bin/fetch-configlet && bin/configlet` to ensure the exercise is configured correctly.

## License

The MIT License (MIT)

Copyright (c) 2016 Katrina Owen, _@kytrinyx.com
