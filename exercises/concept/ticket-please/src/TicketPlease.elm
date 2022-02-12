module TicketPlease exposing (..)


type Ticket
    = Ticket
        { status : Status
        , createdBy : ( User, Int )
        , assignedTo : Maybe User
        , comments : List ( User, String )
        }


type Status
    = New
    | InProgress
    | Resolved
    | Closed
    | Archived


type User
    = User String


emptyComment : ( User, String ) -> Bool
emptyComment =
    Debug.todo "Please implement the function emptyComment"


numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments =
    Debug.todo "Please implement the function numberOfCreatorComments"


assignedToDevTeam : Ticket -> Bool
assignedToDevTeam =
    Debug.todo "Please implement the function assignedToDevTeam"


assignTicketTo : User -> Ticket -> Ticket
assignTicketTo =
    Debug.todo "Please implement the function assignTicketTo"
