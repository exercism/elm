module RestApi exposing (databaseFromJsonString, get, post)

import Dict exposing (Dict)
import Json.Decode exposing (Error)
import Json.Encode


type alias JsonString =
    String


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


databaseFromJsonString : JsonString -> Result Error Database
databaseFromJsonString payload =
    Debug.todo "Please implement databaseFromJsonString"


get : Database -> String -> Maybe JsonString -> JsonString
get database url maybePayload =
    Debug.todo "Please implement get"


post : Database -> String -> JsonString -> JsonString
post database url payload =
    Debug.todo "Please implement post"
