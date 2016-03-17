module Main (..) where

import Task
import Console
import ElmTest exposing (..)

import PhoneNumber exposing (getNumber, printPretty)

tests : Test
tests = suite "PhoneNumber test suite"
      [
        test "cleans number" (assertEqual "1234567890" (getNumber "(123) 456-7890")),
        test "cleans number with dots" (assertEqual "1234567890" (getNumber "123.456.7890")),
        test "valid when 11 digits and first is 1" (assertEqual "1234567890" (getNumber "11234567890")),
        test "invalid when 11 digits" (assertEqual "0000000000" (getNumber "21234567890")),
        test "invalid when 9 digits" (assertEqual "0000000000" (getNumber "123456789")),
        test "invalid when 12 digits" (assertEqual "0000000000" (getNumber "123456789012")),
        test "invalid when empty" (assertEqual "0000000000" (getNumber "")),
        test "invalid when no digits present" (assertEqual "0000000000" (getNumber " (-) ")),
        test "valid with leading characters" (assertEqual "1234567890" (getNumber "my number is 123 456 7890")),
        test "valid with trailing characters" (assertEqual "1234567890" (getNumber "123 456 7890 - bob")),
        test "pretty print" (assertEqual "(123) 456-7890" (printPretty "1234567890")),
        test "pretty print with full us phone number" (assertEqual "(123) 456-7890" (printPretty "11234567890"))
      ]

port runner : Signal (Task.Task x ())
port runner =
  Console.run (consoleRunner tests)

