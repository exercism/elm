module LolCodeParser exposing (..)

import Parser exposing ((|.), (|=), Parser)


type Command
    = Version Int
    | Import String
    | Print String


program : String
program =
    """HAI 1
CAN HAS STDIO?
VISIBLE "HAI WORLD!"
KTHXBYE
"""


singleVersionProgramP : Parser (List Command)
singleVersionProgramP =
    fullProgramP
        |> Parser.andThen
            (\commands ->
                case commands of
                    (Version _) :: (Version _) :: _ ->
                        Parser.problem "Multiple versions defined"

                    _ ->
                        Parser.succeed commands
            )


fullProgramP : Parser (List Command)
fullProgramP =
    programP
        |. Parser.spaces
        |. Parser.end


programP : Parser (List Command)
programP =
    Parser.sequence
        { start = ""
        , separator = "\n"
        , end = "KTHXBYE"
        , spaces = Parser.succeed ()
        , item = commandP
        , trailing = Parser.Optional
        }


commandP : Parser Command
commandP =
    Parser.oneOf
        [ versionP
        , importP
        , printP
        ]


versionP : Parser Command
versionP =
    Parser.succeed Version
        |. Parser.keyword "HAI"
        |. Parser.spaces
        |= Parser.int


importP : Parser Command
importP =
    Parser.succeed Import
        |. Parser.keyword "CAN HAS"
        |. Parser.spaces
        |= packageP
        |. Parser.symbol "?"


packageP : Parser String
packageP =
    Parser.chompWhile Char.isAlphaNum
        |> Parser.getChompedString
        |> Parser.map String.toLower


printP : Parser Command
printP =
    Parser.succeed Print
        |. Parser.keyword "VISIBLE"
        |. Parser.spaces
        |. Parser.symbol "\""
        |= stringP
        |. Parser.symbol "\""


stringP : Parser String
stringP =
    Parser.chompWhile (\c -> c /= '"')
        |> Parser.getChompedString
