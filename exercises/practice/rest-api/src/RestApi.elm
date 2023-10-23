module RestApi exposing (buildDatabase, get, post)

import Dict exposing (Dict)
import Json.Decode exposing (Error)
import Json.Encode


type alias Name =
    String


type alias User =
    { name : Name
    , owes : Dict Name Int
    , owedBy : Dict Name Int
    , balance : Int
    }


type alias Database =
    Dict Name User


buildDatabase : String -> Result Error Database
buildDatabase payload =
    Debug.todo "Please implement buildDatabase"


get : Database -> String -> Maybe String -> String
get database url maybePayload =
    Debug.todo "Please implement get"


post : Database -> String -> String -> String
post database url payload =
    Debug.todo "Please implement post"
