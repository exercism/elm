module StrainTest where

-- TODO - remove example inclusion once Problem sets are ready to go live or CI is set up.

import ElmTest.Test exposing (test, Test, suite)
import ElmTest.Assertion exposing (assert, assertEqual)
import ElmTest.Runner.Element exposing (runDisplay)

import StrainExample exposing (keep, discard)

import String

even = \number -> number % 2 == 0
odd = \number -> number % 2 == 1
isFirstLetter = \letter-> \word -> (String.left 1 word) == letter
lessThanTen = \num -> num < 10

tests : Test
tests = suite "Strain Test Suite"
  [ test "empty keep" (assertEqual [] (keep lessThanTen [])),
    test "keep everything" (assertEqual [1, 2, 3] (keep lessThanTen [1, 2, 3])),
    test "keep first and last" (assertEqual [1, 3] (keep odd [1, 2, 3])),
    test "keep nothing" (assertEqual [] (keep even [1,3,5,7])),
    test "keep neither first nor last" (assertEqual [2] (keep even [1, 2, 3])),
    test "keep strings" (assertEqual ["zebra", "zombies", "zealot"] (keep (isFirstLetter "z") ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"])),
    test "empty discard" (assertEqual [] (discard lessThanTen [])),
    test "discard everything" (assertEqual [] (discard lessThanTen [1, 2, 3])),
    test "discard first and last" (assertEqual [2] (discard odd [1, 2, 3])),
    test "discard nothing" (assertEqual [1,3,5,7] (discard even [1,3,5,7])),
    test "discard neither first nor last" (assertEqual [1, 3] (discard even [1, 2, 3])),
    test "discard strings" (assertEqual ["apple", "banana", "cherimoya"] (discard (isFirstLetter "z") ["apple", "zebra", "banana", "zombies", "cherimoya", "zealot"]))
  ]

main = runDisplay tests
