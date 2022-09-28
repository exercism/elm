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
    Debug.todo "Please implement this parser"


vegetarianParser : Parser Bool
vegetarianParser =
    Debug.todo "Please implement this parser"


wordParser : Parser String
wordParser =
    Debug.todo "Please implement this parser"


ingredientsParser : Parser (List String)
ingredientsParser =
    Debug.todo "Please implement this parser"


pizzaParser : Parser Pizza
pizzaParser =
    Debug.todo "Please implement this parser"


menuParser : Parser (List Pizza)
menuParser =
    Debug.todo "Please implement this parser"


oneIngredientParser : Parser String
oneIngredientParser =
    Debug.todo "Please implement this parser"
