# Generating files for practice exercises

This application is used for generating and pre-populating files for Exercism practice exercises. 

The list of available exercises [can be found on the `problem-specifications` repository](https://github.com/exercism/problem-specifications/tree/main/exercises).
Please [check this link](https://exercism.org/docs/building/tracks/practice-exercises) for the full documentation on practice exercises. 

The generator code is in this folder, you can run it with
```bash
./bin/generate_practice_exercise.sh <exercise-name>
```
from the root of the directory.

Once you run the script, `config.json` will be modified and the following files will be created:
```
exercises/practice/<exercise-name>/
├── .docs
│   └── instructions.md
├── .meta
│   ├── config.json
│   └── src
│       └── <ExerciseName>.example.elm
├── elm.json
├── src
│   └── <ExerciseName>.elm
└── tests
    └── Tests.elm
```

In the rest of the document, we assume that we are in the `exercises/practice/<exercise-name>` directory.

## Solution files

The generator creates stub solution files in `src/<ExerciseName>.elm` and `.meta/src/<ExerciseName>.example.elm`.
The list of function along with arguments and types is derived directly from the values found in the `canonical-data.json` file in `problem-specifications`.

The function names, arguments and types will need to be modified to offer a suitable Elm API.
Don't hesitate to create custom types.

After you have implemented an example solution that passes all the tests, copy it in `.meta/src/<ExerciseName>.example.elm` and cut `src/<ExerciseName>.elm` down to a stub file.

## Test file

The generator creates `tests/Tests.elm` from the values found in the `canonical-data.json` file in `problem-specifications`.

The tests will need to be modified to match the API from `src/<ExerciseName>.elm`.
The file structure and test names should be kept as they are, the test data will require transformation but should remain the same in substance, and comments can be deleted. Don't forget to un-comment every `skip <|` except on the first test.

Please mind that tests that have been re-implemented need to be removed.

Once the test file is finalized, please run `./bin/configlet sync --update --tests --exercise <exercise-name>` from the top of the repository to specify which tests have been implemented.

## Config files

There are two configuration files that you need to complete. 

First, `config.json` on top of the repository. 
Please change the following fields:
- `name`: should be capitalized and spelled in proper English.
- `practices`: should have the list of key concepts the exercise focuses on (one or two).
- `prerequisites`: should have the list of all concepts necessary to complete the exercise. A good rule of thumb is to include the concepts you needed to implement the example solution.
- `difficulty`: an estimation of the difficulty from trivial (1) to very hard (9). Refer to other exercises for scale.

The other config file is in `.meta/config.json`. 
Please modify the following fields:
- `authors`: add your GitHub username to the empty list.
- `contributors`: add this field with a list of GitHub usernames of people who contributed. This can be done after review once the exercise is ready to be merged. Include usernames of reviewers who had a meaningful contribution.

Once `.meta/config.json` has been finalized, please run `./bin/configlet fmt --update --yes --exercise <exercise-name>` from the top of the repository to format it.
