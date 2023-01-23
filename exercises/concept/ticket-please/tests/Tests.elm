module Tests exposing (tests)

import Expect
import Test exposing (Test, describe, test)
import TicketPlease exposing (..)
import TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))


newTicket : { status : Status, createdBy : ( User, Int ), assignedTo : Maybe User, comments : List ( User, String ) }
newTicket =
    { status = New
    , createdBy = ( User "John", 1 )
    , assignedTo = Just (User "Bob")
    , comments = [ ( User "John", "ping?" ), ( User "Bob", "pong!" ) ]
    }


tests : Test
tests =
    describe "TicketPlease "
        [ describe "1"
            [ test "emptyComment should detect an empty comment" <|
                \() ->
                    emptyComment ( User "Alice", "" )
                        |> Expect.equal True
                        |> Expect.onFail "Expected the comment to be empty"
            , test "emptyComment should detect an non-empty comment" <|
                \() ->
                    emptyComment ( User "Alice", "hello" )
                        |> Expect.equal False
                        |> Expect.onFail "Expected the comment to contain something"
            , test "emptyComment can be used in a filter" <|
                \() ->
                    [ ( User "Alice", "hello" )
                    , ( User "Bob", "" )
                    , ( User "Alice", "hello?" )
                    , ( User "Bob", "hi!" )
                    ]
                        |> List.filter (emptyComment >> not)
                        |> Expect.equalLists
                            [ ( User "Alice", "hello" )
                            , ( User "Alice", "hello?" )
                            , ( User "Bob", "hi!" )
                            ]
            ]
        , describe "2"
            [ test "numberOfCreatorComments with no comment" <|
                \() ->
                    Ticket { newTicket | createdBy = ( User "John", 1 ), comments = [] }
                        |> numberOfCreatorComments
                        |> Expect.equal 0
            , test "numberOfCreatorComments with no comment from creator" <|
                \() ->
                    Ticket
                        { newTicket
                            | createdBy = ( User "John", 1 )
                            , comments = [ ( User "Alice", "How may I help you?" ) ]
                        }
                        |> numberOfCreatorComments
                        |> Expect.equal 0
            , test "numberOfCreatorComments with one comment from creator" <|
                \() ->
                    Ticket
                        { newTicket
                            | createdBy = ( User "Jack", 2 )
                            , comments = [ ( User "Jack", "I can't connect to the wifi." ) ]
                        }
                        |> numberOfCreatorComments
                        |> Expect.equal 1
            , test "numberOfCreatorComments with several comments" <|
                \() ->
                    Ticket
                        { newTicket
                            | createdBy = ( User "Steve", 1 )
                            , comments =
                                [ ( User "Roy", "Hello, IT." )
                                , ( User "Steve", "My computer refuses to print anything." )
                                , ( User "Roy", "Have you tried turning it off and on again?" )
                                , ( User "Steve", "Is that a reference to something?" )
                                ]
                        }
                        |> numberOfCreatorComments
                        |> Expect.equal 2
            ]
        , describe "3"
            [ test "assignedToDevTeam with no one assigned" <|
                \() ->
                    Ticket { newTicket | assignedTo = Nothing }
                        |> assignedToDevTeam
                        |> Expect.equal False
                        |> Expect.onFail "Expected unassigned ticket"
            , test "assignedToDevTeam with ticket assigned to non-dev team" <|
                \() ->
                    Ticket { newTicket | assignedTo = Just (User "Roy") }
                        |> assignedToDevTeam
                        |> Expect.equal False
                        |> Expect.onFail "Expected ticket not assigned to dev team"
            , test "assignedToDevTeam with ticket assigned to Alice from dev team" <|
                \() ->
                    Ticket { newTicket | assignedTo = Just (User "Alice") }
                        |> assignedToDevTeam
                        |> Expect.equal True
                        |> Expect.onFail "Expected ticket assigned to Alice from dev team"
            , test "assignedToDevTeam with ticket assigned to Bob from dev team" <|
                \() ->
                    Ticket { newTicket | assignedTo = Just (User "Bob") }
                        |> assignedToDevTeam
                        |> Expect.equal True
                        |> Expect.onFail "Expected ticket assigned to Bob from dev team"
            , test "assignedToDevTeam with ticket assigned to Charlie from dev team" <|
                \() ->
                    Ticket { newTicket | assignedTo = Just (User "Charlie") }
                        |> assignedToDevTeam
                        |> Expect.equal True
                        |> Expect.onFail "Expected ticket assigned to Charlie from dev team"
            ]
        , describe "4"
            [ test "assign new, unassigned ticket to Roy" <|
                \() ->
                    Ticket { newTicket | status = New, assignedTo = Nothing }
                        |> assignTicketTo (User "Roy")
                        |> Expect.equal
                            (Ticket { newTicket | status = InProgress, assignedTo = Just (User "Roy") })
            , test "assign new, assigned ticket to Moss" <|
                \() ->
                    Ticket { newTicket | status = New, assignedTo = Just (User "Alice") }
                        |> assignTicketTo (User "Moss")
                        |> Expect.equal
                            (Ticket { newTicket | status = InProgress, assignedTo = Just (User "Moss") })
            , test "assign in progress, unassigned ticket to Roy" <|
                \() ->
                    Ticket { newTicket | status = InProgress, assignedTo = Nothing }
                        |> assignTicketTo (User "Roy")
                        |> Expect.equal
                            (Ticket { newTicket | status = InProgress, assignedTo = Just (User "Roy") })
            , test "assign in progress, assigned ticket to Moss" <|
                \() ->
                    Ticket { newTicket | status = InProgress, assignedTo = Just (User "Alice") }
                        |> assignTicketTo (User "Moss")
                        |> Expect.equal
                            (Ticket { newTicket | status = InProgress, assignedTo = Just (User "Moss") })
            , test "assign resolved, unassigned ticket to Roy" <|
                \() ->
                    Ticket { newTicket | status = Resolved, assignedTo = Nothing }
                        |> assignTicketTo (User "Roy")
                        |> Expect.equal
                            (Ticket { newTicket | status = Resolved, assignedTo = Just (User "Roy") })
            , test "assign resolved, assigned ticket to Moss" <|
                \() ->
                    Ticket { newTicket | status = Resolved, assignedTo = Just (User "Alice") }
                        |> assignTicketTo (User "Moss")
                        |> Expect.equal
                            (Ticket { newTicket | status = Resolved, assignedTo = Just (User "Moss") })
            , test "assign closed, unassigned ticket to Roy" <|
                \() ->
                    Ticket { newTicket | status = Closed, assignedTo = Nothing }
                        |> assignTicketTo (User "Roy")
                        |> Expect.equal
                            (Ticket { newTicket | status = Closed, assignedTo = Just (User "Roy") })
            , test "assign closed, assigned ticket to Moss" <|
                \() ->
                    Ticket { newTicket | status = Closed, assignedTo = Just (User "Alice") }
                        |> assignTicketTo (User "Moss")
                        |> Expect.equal
                            (Ticket { newTicket | status = Closed, assignedTo = Just (User "Moss") })
            , test "unsuccesfulfy assign archived, unassigned ticket to Roy" <|
                \() ->
                    Ticket { newTicket | status = Archived, assignedTo = Nothing }
                        |> assignTicketTo (User "Roy")
                        |> Expect.equal
                            (Ticket { newTicket | status = Archived, assignedTo = Nothing })
            , test "unsuccesfulfy assign archived, assigned ticket to Moss" <|
                \() ->
                    Ticket { newTicket | status = Archived, assignedTo = Just (User "Alice") }
                        |> assignTicketTo (User "Moss")
                        |> Expect.equal
                            (Ticket { newTicket | status = Archived, assignedTo = Just (User "Alice") })
            ]
        ]
