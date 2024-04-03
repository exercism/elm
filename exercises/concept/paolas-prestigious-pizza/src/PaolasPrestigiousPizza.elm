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
    Parser.problem "Please implement this parser"


vegetarianParser : Parser Bool
vegetarianParser =
    Parser.problem "Please implement this parser"


wordParser : Parser String
wordParser =
    Parser.problem "Please implement this parser"


ingredientsParser : Parser (List String)
ingredientsParser =
    Parser.problem "Please implement this parser"


pizzaParser : Parser Pizza
pizzaParser =
    Parser.problem "Please implement this parser"


menuParser : Parser (List Pizza)
menuParser =
    Parser.problem "Please implement this parser"


oneIngredientParser : Parser String
oneIngredientParser =
    Parser.problem "Please implement this parser"
