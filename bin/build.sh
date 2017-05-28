#!/usr/bin/env bash

# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

if [ ! -f "bin/elm-format" ]; then
  echo "Installing local copy of elm-format"
  bin/install-elm-format
fi

bin/elm-format --yes --validate exercises/**/*.example.elm  exercises/**/tests/Tests.elm

if [ $? -ne 0 ]; then
    echo "*******************************************************************"
    echo "*******************************************************************"
    echo "**                       elm-format failed                       **"
    echo "**        perhaps some of your changes are not formatted?        **"
    echo "**             Please run elm-format before pushing.             **"
    echo "*******************************************************************"
    echo "*******************************************************************"
    exit 1
else
  echo "Formatting looks good!"
fi

# TEST

declare -i TEST_RESULT=0
FAILED_EXERCISES=''

mkdir -p build/tests

for example_file in exercises/**/*.example.elm
do
  # clean up generated code from last run
  rm -rf build/tests/elm-stuff/generated-code/

  exercise_dir=$(dirname $example_file)
  exercise_name=$(basename $example_file .example.elm)
  cp "$exercise_dir/$exercise_name.example.elm" "build/$exercise_name.elm"
  cp "$exercise_dir/tests/elm-package.json" build/tests/
  cp "$exercise_dir/tests/Tests.elm" build/tests/

  echo '-------------------------------------------------------'
  echo "Testing $exercise_name"


  npm test -- build/tests/Tests.elm

  # capture result from last command (elm-test)
  if [ $? -ne 0 ]; then
      TEST_RESULT=1
      FAILED_EXERCISES+="$exercise_name\n"
  fi
done

if [ $TEST_RESULT -ne 0 ]; then
  echo "The following exercises failed"
  printf $FAILED_EXERCISES
  exit $TEST_RESULT
fi
