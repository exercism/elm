#!/usr/bin/env bash

# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

if [ ! -f "bin/elm-format" ] || [[ ! $(bin/elm-format --help | grep "elm-format-0.19 0.8.0") ]]; then
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

rm -rf build/tests/ build/*.elm
mkdir -p build/tests
cp template/elm.json build/

for example_file in exercises/**/*.example.elm
do
  exercise_dir=$(dirname $example_file)
  exercise_name=$(basename $example_file .example.elm)
  cp $example_file "build/$exercise_name.elm"
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$exercise_name/" | sed 's/skip <|//g' > "build/tests/Tests$exercise_name.elm"
done

npm test -- build/tests/
