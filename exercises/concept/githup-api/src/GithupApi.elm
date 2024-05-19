module GithupApi exposing (..)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


type alias User =
    { id : Int
    , name : Maybe String
    , login : String
    , avatarUrl : String
    , siteAdmin : Bool
    }


type Side
    = Left
    | Right


type alias Comment =
    { id : Int
    , pullRequestReviewId : Maybe Int
    , user : User
    , body : String
    , side : Side
    , links : Dict String String
    }


decodeId : Decoder Int
decodeId =
    Decode.fail "Please implement decodeId"


decodeName : Decoder (Maybe String)
decodeName =
    Decode.fail "Please implement decodeName"


decodeUser : Decoder User
decodeUser =
    Decode.fail "Please implement decodeUser"


decodepullRequestReviewId : Decoder (Maybe Int)
decodepullRequestReviewId =
    Decode.fail "Please implement decodepullRequestReviewId"


decodeSide : Decoder Side
decodeSide =
    Decode.fail "Please implement decodeSide"


decodeLinks : Decoder (Dict String String)
decodeLinks =
    Decode.fail "Please implement decodeLinks"


decodeComment : Decoder Comment
decodeComment =
    Decode.fail "Please implement decodeComment"


decodeComments : Decoder (List Comment)
decodeComments =
    Decode.fail "Please implement decodeComments"


encodeComment : Comment -> Value
encodeComment comment =
    Debug.todo "Please implement encodeComment"
