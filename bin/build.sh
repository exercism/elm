#!/usr/bin/env bash

# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

which elm-format > /dev/null

if [ $? -ne 0 ]; then
  echo "elm-format not found"
  exit 1
fi

elm-format --yes --validate exercises/**/*.example.elm  exercises/**/tests/Tests.elm

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
  echo "formatting looks good!"
fi


# TEST

declare -i TEST_RESULT=0
FAILED_EXERCISES=''

for example_file in exercises/**/*.example.elm
do
  # clean up generated code from last run
  rm -rf tests/elm-stuff/generated-code/

  exercise_dir=$(dirname $example_file)
  exercise_name=$(basename $example_file .example.elm)
  mv "$exercise_dir/$exercise_name.elm" "$exercise_dir/$exercise_name.impl"
  mv "$exercise_dir/$exercise_name.example.elm" "$exercise_dir/$exercise_name.elm"
  echo '-------------------------------------------------------'
  echo "Testing $exercise_name"

  cp "$exercise_dir/tests/Tests.elm" tests/

  npm test -- tests/Tests.elm

  # capture result from last command (elm-test)
  if [ $? -ne 0 ]; then
      TEST_RESULT=1
      FAILED_EXERCISES+="$exercise_name\n"
  fi

  # be kind, rewind
  mv "$exercise_dir/$exercise_name.elm" "$exercise_dir/$exercise_name.example.elm"
  mv "$exercise_dir/$exercise_name.impl" "$exercise_dir/$exercise_name.elm"
  rm tests/Tests.elm
done

if [ $TEST_RESULT -ne 0 ]; then
  echo "The following exercises failed"
  printf $FAILED_EXERCISES
  exit $TEST_RESULT
fi
