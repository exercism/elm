declare -i TEST_RESULT=0
FAILED_EXERCISES=''

for example_file in exercises/**/*.example
do
  exercise_dir=$(dirname $example_file)
  exercise=$(basename $example_file .example)
  mv "$exercise_dir/$exercise.elm" "$exercise_dir/$exercise.impl"
  mv "$exercise_dir/$exercise.example" "$exercise_dir/$exercise.elm"
  echo '-------------------------------------------------------'
  echo "Testing $exercise"
  elm-test $exercise_dir/*Tests.elm
  if [ $? -ne 0 ]; then
    TEST_RESULT=1
    FAILED_EXERCISES+="$exercise\n"
  fi
  mv "$exercise_dir/$exercise.elm" "$exercise_dir/$exercise.example"
  mv "$exercise_dir/$exercise.impl" "$exercise_dir/$exercise.elm"
done

if [ $TEST_RESULT -ne 0 ]; then
  echo "The following exercises failed"
  printf $FAILED_EXERCISES
  exit $TEST_RESULT
fi
