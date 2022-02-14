module TicketPlease exposing (..)

import TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))


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
