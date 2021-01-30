#!/usr/bin/env bash

# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

if [[ ! $(npx --no-install elm-format --help | grep "elm-format 0.8.4") ]]; then
  echo "Please run npm install first"
  exit 1
fi

npx --no-install elm-format --yes --validate \
  exercises/concept/**/.meta/*.elm \
  exercises/concept/**/tests/*.elm \
  exercises/practice/**/src/*.example.elm \
  exercises/practice/**/tests/*.elm

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

# Fail if any of the tests fails.
set -e
set -o pipefail

# TEST (concept)

echo "Testing concept exercises ..."
rm -rf build
mkdir -p build/src build/tests
cp template/elm.json build/

for example_file in exercises/concept/**/.meta/*.elm
do
  exercise_dir=$(dirname $(dirname $example_file))
  exercise_name=$(basename $(ls $exercise_dir/src/*.elm) .elm)
  # TODO: check that all exercise_name are unique
  cp $example_file "build/src/$exercise_name.elm"
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "build/tests/Tests$exercise_name.elm"
done

cd build && npx --no-install elm-test
cd ..

# TEST (practice)

echo "Testing practice exercises ..."
rm -rf build
mkdir -p build/src build/tests
cp template/elm.json build/

for example_file in exercises/practice/**/src/*.example.elm
do
  exercise_dir=$(dirname $(dirname $example_file))
  exercise_name=$(basename $example_file .example.elm)
  cp $example_file "build/src/$exercise_name.elm"
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "build/tests/Tests$exercise_name.elm"
done

cd build && npx --no-install elm-test
cd ..
