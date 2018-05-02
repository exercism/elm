# Exercism Elm Track
[![build status](https://travis-ci.org/exercism/elm.svg?branch=master)](https://travis-ci.org/exercism/elm)

Exercism Exercises in Elm

## Setup

The simplest way to install Elm is via Node.js/NPM.

If you don't already have Node.js installed on your computer, you can download it from [the official site](https://nodejs.org/). Once you have Node.js up and running, follow these steps to install the Elm platform and elm-test.

```bash
$ npm install
```

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
[exercism/problem-specifications](https://github.com/exercism/problem-specifications) repository.

- Each exercise should have a test suite, an example solution, a template file for the real implementation and an `elm-package.json` file with the `elm-test` and `elm-console` dependencies. The CI build expects files to be named using the following convention:
  - The example solution should be named `ExerciseModuleName.example`. 
  - The template file should be named `ExerciseModuleName.elm`. 
  - Test file should be named `Tests.elm`.

- The recommended workflow when working on an exercise is to first create the implementation and test files, `ExerciseModuleName.elm` and `tests/Tests.elm`. You'll likely want to copy one of the existing exercise directories as a quick start.
  - Test the new exercise directly by running `npm test` from the exercise directory.

  - Automatically run tests again when you save changes by running `npm run watch` from the exercise directory.

  - Once the implementation of the exercise is complete, rename `ExerciseModuleName.elm` to `ExerciseModuleName.example.elm` and create the template `ExerciseModuleName.elm`.

  - Make sure everything is good to go by running all tests with `bin/build.sh`.

- Please do not commit any Elm configuration files or directories inside the exercise, such as `elm-stuff`. Please include only the standard `elm-package.json`.

- Test files should use the following format:

  ```elm

  module Tests exposing (..)

  import Test exposing (..)
  import Expect
  import ExerciseModuleName


  tests : Test
  tests =
      describe "Bob"
          [ test "first test" <|
              \() ->
                  True
                      |> Expect.equal True
          , test "second test" <|
              \() ->
                  False
                      |> Expect.equal False
          ]
  ```

 - All the tests for Exercism Elm Track exercises can be run from the top level of the repo with `bin/build.sh`. Please run this command before submitting your PR.

 - If you are submitting a new exercise, be sure to add it to the appropriate place in the `config.json` file. Also, please run `bin/fetch-configlet && bin/configlet` to ensure the exercise is configured correctly.

### Generating Setup

To make implementing a new exercise a little bit easier, a new script was added
to the `bin` folder. Running `bin/stub-new-exercise <exercise-slug>` will setup
the exercise folder and then re-direct you back to this section of the README to
do the next steps.

The next steps after generating the files include

1. Run `bin/configlet uuid` to generate a UUID for placing in `config.json`
2. Add the exercise configuration to `config.json`, replacing the placeholders
   with the exercise specific information
   ```json
   {
     "core": false,
     "difficulty": 1,
     "slug": "<exercise-slug",
     "topics": null,
     "unlocked_by": null,
     "uuid": "<generated-uuid>"
   }
   ```
   **Note**: Each exercise configuration will be different by potentially more than
   the UUID. If you have questions, you can wait until submitting the PR and it can
   get resolved then.
3. The following search shows all the locations in the template files you need
   to change before renaming them to just `*.elm` files instead of
   `*.elm.template`.
   ```bash
   $ grep -r "{exercise}" exercises/<exercise>
   ./Exercise.elm.template:module {exercise} exposing ({method})
   ./Exercise.example.elm.template:module {exercise} exposing ({method})
   ./tests/Tests.elm.template:import {exercise} exposing ({method})
   ./tests/Tests.elm.template:    describe "{exercise}"
   $ grep -r "{function}" exercises/<exercise>
   ./Exercise.elm.template:module {exercise} exposing ({function})
   ./Exercise.elm.template:{function} =
   ./Exercise.example.elm.template:module {exercise} exposing ({function})
   ./Exercise.example.elm.template:{function} =
   ./tests/Tests.elm.template:import {exercise} exposing ({function})
   ```
3. The `bin/stub-new-exercise` script has to pull down the
   `problem-specifications` repo to generate the README. You will also be
   able to get the canonical test data from that repo in the
   `exercises/<exercise-slug>/canonical-data.json` file. With the test data, you
   should have enough to get started with the tests.
4. After the tests are written, you can start writing an implementation example
   in `<exercise>.example.elm`.
5. Also remember to stub out the `<exercise>.elm` file, which is what users will
   get when they run `exercism fetch`.

### Elm icon
We were unable to find copyright information about the Elm logo, nor information about who designed it. Presumably Evan Czaplicki, creator of the Elm language, also made the logo, and holds copyright. It may also fall within the public domain, since it is a geometric shape. We've adapted the official Elm logo by changing the colors, which we believe falls under "fair use".
