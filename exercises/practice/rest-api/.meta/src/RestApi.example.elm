module RestApi exposing (buildDatabase, get, post)

import Dict exposing (Dict)
import Json.Decode as Decode exposing (Decoder, Error)
import Json.Encode as Encode exposing (Value)


type alias Name =
    String


type alias User =
    { name : Name
    , owes : Dict Name Int
    , owedBy : Dict Name Int
    , balance : Int
    }


type alias IOU =
    { lender : Name, borrower : Name, amount : Int }


type alias Database =
    Dict Name User


type PostPayload
    = NewUser User
    | NewIOU IOU


buildDatabase : String -> Result Error Database
buildDatabase =
    Decode.decodeString databaseDecoder


get : Database -> String -> Maybe String -> String
get database url maybePayload =
    case ( url, Maybe.map (Decode.decodeString getPayloadDecoder) maybePayload ) of
        ( "/users", Nothing ) ->
            Encode.encode 0 (encodeDatabase database)

        ( "/users", Just (Ok names) ) ->
            database
                |> Dict.filter (\name _ -> List.member name names)
                |> encodeDatabase
                |> Encode.encode 0

        _ ->
            "error"


post : Database -> String -> String -> String
post database url payload =
    case ( url, Decode.decodeString postPayloadDecoder payload ) of
        ( "/add", Ok (NewUser user) ) ->
            Encode.encode 0 (encodeUser user)

        ( "/iou", Ok (NewIOU ({ lender, borrower } as iou)) ) ->
            database
                |> addIOU iou
                |> Dict.filter (\name _ -> List.member name [ lender, borrower ])
                |> encodeDatabase
                |> Encode.encode 0

        _ ->
            "error"


newUser : Name -> User
newUser name =
    User name Dict.empty Dict.empty 0


addIOU : IOU -> Database -> Database
addIOU { lender, borrower, amount } database =
    let
        addCredit user =
            { user
                | owedBy = Dict.update borrower increaseAmount user.owedBy
                , balance = user.balance + amount
            }

        addDebt user =
            { user
                | owes = Dict.update lender increaseAmount user.owes
                , balance = user.balance - amount
            }

        increaseAmount =
            Maybe.withDefault 0 >> (+) amount >> Just

        normalize user =
            let
                ignore _ _ =
                    identity

                keepDifference name a b =
                    case compare a b of
                        GT ->
                            Dict.insert name (a - b)

                        _ ->
                            identity

                owes =
                    Dict.merge Dict.insert keepDifference ignore user.owes user.owedBy Dict.empty

                owedBy =
                    Dict.merge Dict.insert keepDifference ignore user.owedBy user.owes Dict.empty
            in
            { user | owes = owes, owedBy = owedBy }
    in
    database
        |> Dict.update lender (Maybe.withDefault (newUser lender) >> addCredit >> normalize >> Just)
        |> Dict.update borrower (Maybe.withDefault (newUser borrower) >> addDebt >> normalize >> Just)



-- DECODERS


databaseDecoder : Decoder Database
databaseDecoder =
    userDecoder
        |> Decode.list
        |> Decode.field "users"
        |> Decode.map
            (List.map (\user -> ( user.name, user ))
                >> Dict.fromList
            )


userDecoder : Decoder User
userDecoder =
    Decode.map4 User
        (Decode.field "name" Decode.string)
        (Decode.field "owes" (Decode.dict Decode.int))
        (Decode.field "owed_by" (Decode.dict Decode.int))
        (Decode.field "balance" Decode.int)


getPayloadDecoder : Decoder (List Name)
getPayloadDecoder =
    Decode.list Decode.string |> Decode.field "users"


postPayloadDecoder : Decoder PostPayload
postPayloadDecoder =
    Decode.oneOf [ newUserDecoder, newIOUDecoder ]


newUserDecoder : Decoder PostPayload
newUserDecoder =
    Decode.field "user" Decode.string
        |> Decode.map (\name -> NewUser (newUser name))


newIOUDecoder : Decoder PostPayload
newIOUDecoder =
    Decode.map3 IOU
        (Decode.field "lender" Decode.string)
        (Decode.field "borrower" Decode.string)
        (Decode.field "amount" Decode.int)
        |> Decode.map NewIOU



-- ENCODERS


encodeDatabase : Database -> Value
encodeDatabase database =
    Encode.object
        [ ( "users", database |> Dict.toList |> Encode.list (Tuple.second >> encodeUser) )
        ]


encodeUser : User -> Value
encodeUser { name, owes, owedBy, balance } =
    Encode.object
        [ ( "name", Encode.string name )
        , ( "owes", Encode.dict identity Encode.int owes )
        , ( "owed_by", Encode.dict identity Encode.int owedBy )
        , ( "balance", Encode.int balance )
        ]
