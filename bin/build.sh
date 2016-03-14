for example_file in exercises/**/*.example
do
  exercise_dir=$(dirname $example_file)
  exercise=$(basename $example_file .example)
  mv "$exercise_dir/$exercise.elm" "$exercise_dir/$exercise.impl"
  mv "$exercise_dir/$exercise.example" "$exercise_dir/$exercise.elm"
  echo '-------------------------------------------------------'
  echo "Testing $exercise"
  elm-test $exercise_dir/*Tests.elm
  TEST_RESULT=$?
  mv "$exercise_dir/$exercise.elm" "$exercise_dir/$exercise.example"
  mv "$exercise_dir/$exercise.impl" "$exercise_dir/$exercise.elm"

  if [ $TEST_RESULT -ne 0 ]; then
    echo "$exercise failed";
    exit $TEST_RESULT;
  fi
done
