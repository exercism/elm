module Tests exposing (tests)

import Expect
import SqueakyClean exposing (..)
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "Squaky Clean"
        [ describe "Clean1" [ testTask1 clean1 ]
        , skip <|
            describe "Clean2"
                [ testTask1 clean2
                , testTask2 clean2
                ]
        , skip <|
            describe "Clean3"
                [ testTask1 clean3
                , testTask2 clean3
                , testTask3 clean3
                ]
        , skip <|
            describe "Clean4"
                [ testTask1 clean4
                , testTask2 clean4
                , testTask3 clean4
                , testTask4 clean4
                ]
        , skip <|
            describe "Clean5"
                [ testTask1 clean5
                , testTask2 clean5
                , testTask3 clean5
                , testTask4 clean5
                , testTask5 clean5
                ]
        ]


testTask1 : (String -> String) -> Test
testTask1 fn =
    describe "Task 1"
        [ test "Empty String" <|
            \_ ->
                fn ""
                    |> Expect.equal ""
        , test "Keep single character" <|
            \_ ->
                fn "A"
                    |> Expect.equal "A"
        , test "Keep any unicode character" <|
            \_ ->
                fn "àḃç"
                    |> Expect.equal "àḃç"
        , test "replace white space with underscores" <|
            \_ ->
                fn "my   Id"
                    |> Expect.equal "my___Id"
        ]


testTask2 : (String -> String) -> Test
testTask2 fn =
    describe "Task 2"
        [ test "Replace control characters with '[CTRL]'" <|
            \_ ->
                fn "my\tId"
                    |> Expect.equal "my[CTRL]Id"
        , test "Two carriage returns" <|
            \_ ->
                fn "Line one.\u{000D}Line two.\u{000D}"
                    |> Expect.equal "Line_one.[CTRL]Line_two.[CTRL]"
        ]


testTask3 : (String -> String) -> Test
testTask3 fn =
    describe "Task 3"
        [ test "kebab-case to camelCase" <|
            \_ ->
                fn "à-ḃç"
                    |> Expect.equal "àḂç"
        ]


testTask4 : (String -> String) -> Test
testTask4 fn =
    describe "Task 4"
        [ test "Omit digits" <|
            \_ ->
                fn "1My2Finder3"
                    |> Expect.equal "MyFinder"
        ]


testTask5 : (String -> String) -> Test
testTask5 fn =
    describe "Task 5"
        [ test "Omit emoticons" <|
            \_ ->
                fn "My😀😀Finder😀"
                    |> Expect.equal "MyFinder"
        , test "Omit lower case Greek letters" <|
            \_ ->
                fn "My Οβιεγτ Finder"
                    |> Expect.equal "My_Ο_Finder"
        , test "Combined conversions" <|
            \_ ->
                fn "9 -abcĐ😀ω\u{000D}"
                    |> Expect.equal "_AbcĐ[CTRL]"
        ]
