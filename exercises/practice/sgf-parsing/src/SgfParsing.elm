module SgfParsing exposing (Tree(..), parse)

import Dict exposing (Dict)


type Tree
    = Node { properties : Dict String (List String), children : List Tree }


parse : String -> Result String Tree
parse input =
    Debug.todo "Please implement this function"
