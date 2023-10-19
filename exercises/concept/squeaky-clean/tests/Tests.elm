module Tests exposing (tests)

import Expect
import SqueakyClean exposing (clean, clean1, clean2, clean3, clean4)
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "Squeaky Clean"
        [ describe "1"
            [ test "Empty String" <|
                \_ ->
                    clean1 ""
                        |> Expect.equal ""
            , test "Keep single character" <|
                \_ ->
                    clean1 "A"
                        |> Expect.equal "A"
            , test "Keep any unicode character" <|
                \_ ->
                    clean1 "àḃç"
                        |> Expect.equal "àḃç"
            , test "replace white space with underscores" <|
                \_ ->
                    clean1 "my   Id"
                        |> Expect.equal "my___Id"
            ]
        , describe "2"
            [ test "Empty String" <|
                \_ ->
                    clean2 ""
                        |> Expect.equal ""
            , test "Keep single character" <|
                \_ ->
                    clean2 "A"
                        |> Expect.equal "A"
            , test "Keep any unicode character" <|
                \_ ->
                    clean2 "àḃç"
                        |> Expect.equal "àḃç"
            , test "replace white space with underscores" <|
                \_ ->
                    clean2 "my   Id"
                        |> Expect.equal "my___Id"
            , test "Replace control characters with '[CTRL]'" <|
                \_ ->
                    clean2 "my\tId"
                        |> Expect.equal "my[CTRL]Id"
            , test "Two carriage returns" <|
                \_ ->
                    clean2 "Line one.\u{000D}Line two.\u{000D}"
                        |> Expect.equal "Line_one.[CTRL]Line_two.[CTRL]"
            ]
        , describe "3"
            [ test "Empty String" <|
                \_ ->
                    clean3 ""
                        |> Expect.equal ""
            , test "Keep single character" <|
                \_ ->
                    clean3 "A"
                        |> Expect.equal "A"
            , test "Keep any unicode character" <|
                \_ ->
                    clean3 "àḃç"
                        |> Expect.equal "àḃç"
            , test "replace white space with underscores" <|
                \_ ->
                    clean3 "my   Id"
                        |> Expect.equal "my___Id"
            , test "Replace control characters with '[CTRL]'" <|
                \_ ->
                    clean3 "my\tId"
                        |> Expect.equal "my[CTRL]Id"
            , test "Two carriage returns" <|
                \_ ->
                    clean3 "Line one.\u{000D}Line two.\u{000D}"
                        |> Expect.equal "Line_one.[CTRL]Line_two.[CTRL]"
            , test "kebab-case to camelCase" <|
                \_ ->
                    clean3 "à-ḃç"
                        |> Expect.equal "àḂç"
            ]
        , describe "4"
            [ test "Empty String" <|
                \_ ->
                    clean4 ""
                        |> Expect.equal ""
            , test "Keep single character" <|
                \_ ->
                    clean4 "A"
                        |> Expect.equal "A"
            , test "Keep any unicode character" <|
                \_ ->
                    clean4 "àḃç"
                        |> Expect.equal "àḃç"
            , test "replace white space with underscores" <|
                \_ ->
                    clean4 "my   Id"
                        |> Expect.equal "my___Id"
            , test "Replace control characters with '[CTRL]'" <|
                \_ ->
                    clean4 "my\tId"
                        |> Expect.equal "my[CTRL]Id"
            , test "Two carriage returns" <|
                \_ ->
                    clean4 "Line one.\u{000D}Line two.\u{000D}"
                        |> Expect.equal "Line_one.[CTRL]Line_two.[CTRL]"
            , test "kebab-case to camelCase" <|
                \_ ->
                    clean4 "à-ḃç"
                        |> Expect.equal "àḂç"
            , test "Omit digits" <|
                \_ ->
                    clean4 "1My2Finder3"
                        |> Expect.equal "MyFinder"
            ]
        , describe "5"
            [ test "Empty String" <|
                \_ ->
                    clean ""
                        |> Expect.equal ""
            , test "Keep single character" <|
                \_ ->
                    clean "A"
                        |> Expect.equal "A"
            , test "Keep any unicode character" <|
                \_ ->
                    clean "àḃç"
                        |> Expect.equal "àḃç"
            , test "replace white space with underscores" <|
                \_ ->
                    clean "my   Id"
                        |> Expect.equal "my___Id"
            , test "Replace control characters with '[CTRL]'" <|
                \_ ->
                    clean "my\tId"
                        |> Expect.equal "my[CTRL]Id"
            , test "Two carriage returns" <|
                \_ ->
                    clean "Line one.\u{000D}Line two.\u{000D}"
                        |> Expect.equal "Line_one.[CTRL]Line_two.[CTRL]"
            , test "kebab-case to camelCase" <|
                \_ ->
                    clean "à-ḃç"
                        |> Expect.equal "àḂç"
            , test "Omit digits" <|
                \_ ->
                    clean "1My2Finder3"
                        |> Expect.equal "MyFinder"
            , test "Omit lower case Greek letters" <|
                \_ ->
                    clean "My Οβιεγτ Finder"
                        |> Expect.equal "My_Ο_Finder"
            , test "Combined conversions" <|
                \_ ->
                    clean "9 -abcĐ0ω\u{000D}"
                        |> Expect.equal "_AbcĐ[CTRL]"
            ]
        ]
