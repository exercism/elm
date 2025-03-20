#!/usr/bin/env bash
# Fail if any check fails.
set -e
set -o pipefail

# SANITY CHECKS

echo "Checking that all elm.json files are identical to template/elm.json"
for elm_json in exercises/*/*/elm.json
do
  diff -w template/elm.json $elm_json
done
echo "All elm.json files are identical to template/elm.json"

# Elm files with the same name would get overriden in tests below
repeated=$(ls exercises/concept/*/src/*.elm | xargs -n 1 basename | sort | uniq --repeated)
if [[ $repeated ]]; then
    echo "There are files in concept exercises with identical names:"
    echo $repeated
    exit 1
fi
repeated=$(ls exercises/practice/*/src/*.elm | xargs -n 1 basename | sort | uniq --repeated)
if [[ $repeated ]]; then
    echo "There are files in practice exercises with identical names:"
    echo $repeated
    exit 1
fi
echo "All exercise Elm files have unique names"


# FORMAT

echo '-------------------------------------------------------'
echo "Checking Formatting"

if [[ ! $(npx --no-install elm-format --help | grep "elm-format 0.8.5") ]]; then
  echo "elm-format not found or wrong version, please run `elm-tooling install` first."
  exit 1
fi

npx --no-install elm-format --yes --validate \
  exercises/concept/**/.meta/*.elm \
  exercises/concept/**/src/*.elm \
  exercises/concept/**/tests/*.elm \
  exercises/practice/**/.meta/src/*.example.elm \
  exercises/practice/**/src/*.elm \
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

# TEST (concept)

echo "Testing concept exercises ..."
rm -rf build
mkdir -p build/src build/tests
cp template/elm.json build/

for exemplar_file in exercises/concept/**/.meta/*.elm
do
  exercise_dir=$(dirname $(dirname ${exemplar_file}))
  # solution_file is src/ValentinesDay.elm or similar from config.json
  solution_file=$(jq --raw-output '.files.solution | .[0]' "${exercise_dir}/.meta/config.json")
  # solution_file_stub is ValentinesDay or similar
  solution_file_stub=$(echo ${solution_file} | sed -r 's/src\/([a-zA-Z]*)\.elm/\1/')
  
  cp $exercise_dir/src/*.elm "build/src/"
  cp $exemplar_file "build/src/$solution_file_stub.elm"
  # Copy tests files under a unique temporary directory and remove all "skip <| ..."
  cat "$exercise_dir/tests/Tests.elm" | sed "s/module Tests/module Tests$solution_file_stub/" | sed 's/skip <|//g' > "build/tests/Tests$solution_file_stub.elm"
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
