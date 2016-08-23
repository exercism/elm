#!/usr/bin/env bash

declare -i TEST_RESULT=0
FAILED_EXERCISES=''

elm-package install

for example_file in exercises/**/*.example
do
  exercise_dir=$(dirname $example_file)
  exercise=$(basename $example_file .example)
  mv "$exercise_dir/$exercise.elm" "$exercise_dir/$exercise.impl"
  mv "$exercise_dir/$exercise.example" "$exercise_dir/$exercise.elm"
  echo '-------------------------------------------------------'
  echo "Testing $exercise"

  # prevent elm-test from installing dependencies
  mv $exercise_dir/elm-package.json $exercise_dir/elm-package.json.disabled

  elm-test $exercise_dir/*Tests.elm

  # capture result from last command (elm-test)
  if [ $? -ne 0 ]; then
      TEST_RESULT=1
      FAILED_EXERCISES+="$exercise\n"
  fi

  # be kind, rewind
  mv $exercise_dir/elm-package.json.disabled $exercise_dir/elm-package.json

  if [ $WITH_FORMAT ]; then
    elm-format $exercise_dir/*.elm --yes
  fi

  mv "$exercise_dir/$exercise.elm" "$exercise_dir/$exercise.example"
  mv "$exercise_dir/$exercise.impl" "$exercise_dir/$exercise.elm"
done

if [ $TEST_RESULT -ne 0 ]; then
  echo "The following exercises failed"
  printf $FAILED_EXERCISES
  exit $TEST_RESULT
fi

if [ $WITH_FORMAT ]; then
  git diff --quiet --exit-code

  if [ $? -ne 0 ]; then
      echo "*******************************************************************"
      echo "*******************************************************************"
      echo "**Git diff found - perhaps some of your changes are not formatted?*"
      echo "**       Please inspect the diffs before pushing.                **"
      echo "*******************************************************************"
      echo "*******************************************************************"
      exit 1
  fi
fi

