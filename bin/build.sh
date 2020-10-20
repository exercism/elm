#!/usr/bin/env bash

# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

if [[ ! $(npx --no-install elm-format --help | grep "elm-format 0.8.4") ]]; then
  echo "Please run npm install first"
  exit 1
fi

npx --no-install elm-format --yes --validate exercises/**/src/*.example.elm  exercises/**/tests/Tests.elm

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

rm -rf build/src build/tests
mkdir -p build/src build/tests
cp template/elm.json build/

for example_file in exercises/**/src/*.example.elm
do
  exercise_dir=$(dirname $(dirname $example_file))
  exercise_name=$(basename $example_file .example.elm)
  cp $example_file "build/src/$exercise_name.elm"
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "build/tests/Tests$exercise_name.elm"
done

npm test -- build/tests
