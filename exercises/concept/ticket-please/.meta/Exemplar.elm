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
emptyComment ( _, comment ) =
    String.isEmpty comment


numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments (Ticket { createdBy, comments }) =
    let
        ( creator, _ ) =
            createdBy
    in
    List.length
        (List.filter (\( user, _ ) -> user == creator) comments)


assignedToDevTeam : Ticket -> Bool
assignedToDevTeam (Ticket { assignedTo }) =
    case assignedTo of
        Just (User "Alice") ->
            True

        Just (User "Bob") ->
            True

        Just (User "Charlie") ->
            True

        _ ->
            False


assignTicketTo : User -> Ticket -> Ticket
assignTicketTo user (Ticket ({ status } as ticket)) =
    case status of
        New ->
            Ticket { ticket | status = InProgress, assignedTo = Just user }

        Archived ->
            Ticket ticket

        _ ->
            Ticket { ticket | assignedTo = Just user }
