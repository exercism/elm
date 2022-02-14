module TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))


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
