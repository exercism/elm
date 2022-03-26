#!/usr/bin/env bash

# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

if [[ ! $(npx --no-install elm-format --help | grep "elm-format 0.8.5") ]]; then
  echo "elm-format not found or wrong version, please run `elm-tooling install` first."
  exit 1
fi

npx --no-install elm-format --yes --validate \
  exercises/concept/**/.meta/*.elm \
  exercises/concept/**/tests/*.elm \
  exercises/practice/**/.meta/src/*.example.elm \
  exercises/practice/**/tests/*.elm

if [ $? -ne 0 ]; then
  echo "*******************************************************************"
  echo "**                       elm-format failed                       **"
  echo "**        perhaps some of your changes are not formatted?        **"
  echo "**             Please run elm-format before pushing.             **"
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
  # get kebab-case slug and transform it to PascalCase
  exercise_name=$(basename $exercise_dir | sed -r 's/(^|-)([a-z])/\U\2/g')
  # TODO: check that all exercise_name are unique
  cp $exercise_dir/src/*.elm "build/src/"
  cp $example_file "build/src/$exercise_name.elm"
  # Copy tests files under a unique temporary directory and remove all "skip <| ..."
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "build/tests/Tests$exercise_name.elm"
done

cd build && npx --no-install elm-test-rs --fuzz 10
cd ..

# TEST (practice)

echo "Testing practice exercises ..."
rm -rf build
mkdir -p build/src build/tests
cp template/elm.json build/

for example_file in exercises/practice/**/.meta/src/*.example.elm
do
  exercise_dir=$(dirname $(dirname $(dirname $example_file)))
  exercise_name=$(basename $example_file .example.elm)
  cp $example_file "build/src/$exercise_name.elm"
  # Copy tests files under a unique temporary directory and remove all "skip <| ..."
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "build/tests/Tests$exercise_name.elm"
done

cd build && npx --no-install elm-test-rs --fuzz 10
cd ..
