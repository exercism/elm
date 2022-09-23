module PaolasPrestigiousPizza exposing
    ( Pizza
    , ingredientsParser
    , menuParser
    , oneIngredientParser
    , pizzaParser
    , priceParser
    , vegetarianParser
    , wordParser
    )

import Parser exposing ((|.), (|=), Parser)


type alias Pizza =
    { name : String
    , vegetarian : Bool
    , ingredients : List String
    , price : Int
    }


priceParser : Parser Int
priceParser =
    Parser.int
        |. Parser.symbol "€"


vegetarianParser : Parser Bool
vegetarianParser =
    Parser.oneOf
        [ Parser.map (always True) (Parser.symbol "(v)")
        , Parser.succeed False
        ]


wordParser : Parser String
wordParser =
    Parser.chompWhile Char.isAlpha
        |> Parser.getChompedString


ingredientsParser : Parser (List String)
ingredientsParser =
    sequenceParser "," oneIngredientParser


pizzaParser : Parser Pizza
pizzaParser =
    Parser.succeed Pizza
        |= wordParser
        |. Parser.spaces
        |= vegetarianParser
        |. Parser.spaces
        |. Parser.symbol ":"
        |. Parser.spaces
        |= ingredientsParser
        |. Parser.spaces
        |. Parser.symbol "-"
        |. Parser.spaces
        |= priceParser


menuParser : Parser (List Pizza)
menuParser =
    sequenceParser "" pizzaParser |. Parser.end


oneIngredientParser : Parser String
oneIngredientParser =
    Parser.chompWhile (\c -> Char.isAlpha c || c == ' ')
        |> Parser.getChompedString
        |> Parser.andThen
            (\str ->
                if String.isEmpty str then
                    Parser.problem "empty string"

                else
                    Parser.succeed (String.trim str)
            )


sequenceParser : String -> Parser a -> Parser (List a)
sequenceParser separator itemParser =
    Parser.sequence
        { start = ""
        , separator = separator
        , end = ""
        , spaces = Parser.spaces
        , item = itemParser
        , trailing = Parser.Optional
        }
