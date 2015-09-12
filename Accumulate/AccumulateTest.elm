module AccumulateTest where

-- TODO - remove example inclusion once Problem sets are ready to go live or CI is set up.

import AccumulateExample exposing (accumulate)
import ElmTest.Test exposing (test, Test, suite)
import ElmTest.Assertion exposing (assert, assertEqual)
import ElmTest.Runner.Element exposing (runDisplay)
import String

square : Int -> Int
square x = x * x

tests : Test
tests = suite "Accumulate"
        [ test "[]] Accumulate" (assertEqual [] (accumulate square [])),
          test "square Accumulate" (assertEqual [1,4,9] (accumulate square [1,2,3])),
          test "toUpper Accumulate" (assertEqual ["HELLO","WORLD"] (accumulate String.toUpper ["hello" , "world"])),
          test "reverse Accumulate" (assertEqual ["olleh","dlrow"] (accumulate String.reverse ["hello" , "world"]))
        ]

main = runDisplay tests
