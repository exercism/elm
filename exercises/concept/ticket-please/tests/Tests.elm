module Tests exposing (task1, task2, task3, task4)

import Expect
import Test exposing (Test, describe, test)
import TicketPlease exposing (..)


task1 : Test
task1 =
    describe "Task 1: TicketsPlease.emptyComment"
        [ test "emptyComment should detect an empty comment" <|
            \() ->
                emptyComment ( User "Alice", "" )
                    |> Expect.true "Expected the comment to be empty"
        , test "emptyComment should detect an non-empty comment" <|
            \() ->
                emptyComment ( User "Alice", "hello" )
                    |> Expect.false "Expected the comment to contain something"
        , test "emptyComment can be used in a filter" <|
            \() ->
                [ ( User "Alice", "hello" ), ( User "Bob", "" ), ( User "Alice", "hello?" ), ( User "Bob", "hi!" ) ]
                    |> List.filter (emptyComment >> not)
                    |> Expect.equalLists [ ( User "Alice", "hello" ), ( User "Alice", "hello?" ), ( User "Bob", "hi!" ) ]
        ]


task2 : Test
task2 =
    describe "Task 2: TicketsPlease.numberOfCreatorComments"
        [ test "numberOfCreatorComments with no comment" <|
            \() ->
                Ticket { status = New, createdBy = ( User "John", 1 ), assignedTo = Nothing, comments = [] }
                    |> numberOfCreatorComments
                    |> Expect.equal 0
        , test "numberOfCreatorComments with no comment from creator" <|
            \() ->
                Ticket
                    { status = InProgress
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Just (User "Alice")
                    , comments = [ ( User "Alice", "How may I help you?" ) ]
                    }
                    |> numberOfCreatorComments
                    |> Expect.equal 0
        , test "numberOfCreatorComments with one comment from creator" <|
            \() ->
                Ticket
                    { status = New
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Nothing
                    , comments = [ ( User "John", "I can't connect to the wifi." ) ]
                    }
                    |> numberOfCreatorComments
                    |> Expect.equal 1
        , test "numberOfCreatorComments with several comments" <|
            \() ->
                Ticket
                    { status = InProgress
                    , createdBy = ( User "Steve", 1 )
                    , assignedTo = Just (User "Roy")
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


task3 : Test
task3 =
    describe "Task 3: TicketsPlease.assignedToDevTeam"
        [ test "assignedToDevTeam with no one assigned" <|
            \() ->
                Ticket { status = New, createdBy = ( User "John", 1 ), assignedTo = Nothing, comments = [] }
                    |> assignedToDevTeam
                    |> Expect.false "Expected unassigned ticket"
        , test "assignedToDevTeam with ticket assigned to non-dev team" <|
            \() ->
                Ticket { status = New, createdBy = ( User "Jack", 2 ), assignedTo = Just (User "Roy"), comments = [] }
                    |> assignedToDevTeam
                    |> Expect.false "Expected ticket not assigned to dev team"
        , test "assignedToDevTeam with ticket assigned to Alice from dev team" <|
            \() ->
                Ticket { status = New, createdBy = ( User "Jim", 3 ), assignedTo = Just (User "Alice"), comments = [] }
                    |> assignedToDevTeam
                    |> Expect.true "Expected ticket assigned to Alice from dev team"
        , test "assignedToDevTeam with ticket assigned to Bob from dev team" <|
            \() ->
                Ticket { status = New, createdBy = ( User "James", 4 ), assignedTo = Just (User "Bob"), comments = [] }
                    |> assignedToDevTeam
                    |> Expect.true "Expected ticket assigned to Bob from dev team"
        , test "assignedToDevTeam with ticket assigned to Charlie from dev team" <|
            \() ->
                Ticket { status = New, createdBy = ( User "Jeremy", 5 ), assignedTo = Just (User "Charlie"), comments = [] }
                    |> assignedToDevTeam
                    |> Expect.true "Expected ticket assigned to Charlie from dev team"
        ]


task4 : Test
task4 =
    describe "Task 4: TicketsPlease.assignTicketTo"
        [ test "assign new, unassigned ticket to Roy" <|
            \() ->
                Ticket
                    { status = New
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Nothing
                    , comments = []
                    }
                    |> assignTicketTo (User "Roy")
                    |> Expect.equal
                        (Ticket
                            { status = InProgress
                            , createdBy = ( User "John", 1 )
                            , assignedTo = Just (User "Roy")
                            , comments = []
                            }
                        )
        , test "assign new, assigned ticket to Moss" <|
            \() ->
                Ticket
                    { status = New
                    , createdBy = ( User "Jack", 2 )
                    , assignedTo = Just (User "Alice")
                    , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                    }
                    |> assignTicketTo (User "Moss")
                    |> Expect.equal
                        (Ticket
                            { status = InProgress
                            , createdBy = ( User "Jack", 2 )
                            , assignedTo = Just (User "Moss")
                            , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                            }
                        )
        , test "assign in progress, unassigned ticket to Roy" <|
            \() ->
                Ticket
                    { status = InProgress
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Nothing
                    , comments = []
                    }
                    |> assignTicketTo (User "Roy")
                    |> Expect.equal
                        (Ticket
                            { status = InProgress
                            , createdBy = ( User "John", 1 )
                            , assignedTo = Just (User "Roy")
                            , comments = []
                            }
                        )
        , test "assign in progress, assigned ticket to Moss" <|
            \() ->
                Ticket
                    { status = InProgress
                    , createdBy = ( User "Jack", 2 )
                    , assignedTo = Just (User "Alice")
                    , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                    }
                    |> assignTicketTo (User "Moss")
                    |> Expect.equal
                        (Ticket
                            { status = InProgress
                            , createdBy = ( User "Jack", 2 )
                            , assignedTo = Just (User "Moss")
                            , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                            }
                        )
        , test "assign resolved, unassigned ticket to Roy" <|
            \() ->
                Ticket
                    { status = Resolved
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Nothing
                    , comments = []
                    }
                    |> assignTicketTo (User "Roy")
                    |> Expect.equal
                        (Ticket
                            { status = Resolved
                            , createdBy = ( User "John", 1 )
                            , assignedTo = Just (User "Roy")
                            , comments = []
                            }
                        )
        , test "assign resolved, assigned ticket to Moss" <|
            \() ->
                Ticket
                    { status = Resolved
                    , createdBy = ( User "Jack", 2 )
                    , assignedTo = Just (User "Alice")
                    , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                    }
                    |> assignTicketTo (User "Moss")
                    |> Expect.equal
                        (Ticket
                            { status = Resolved
                            , createdBy = ( User "Jack", 2 )
                            , assignedTo = Just (User "Moss")
                            , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                            }
                        )
        , test "assign closed, unassigned ticket to Roy" <|
            \() ->
                Ticket
                    { status = Closed
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Nothing
                    , comments = []
                    }
                    |> assignTicketTo (User "Roy")
                    |> Expect.equal
                        (Ticket
                            { status = Closed
                            , createdBy = ( User "John", 1 )
                            , assignedTo = Just (User "Roy")
                            , comments = []
                            }
                        )
        , test "assign closed, assigned ticket to Moss" <|
            \() ->
                Ticket
                    { status = Closed
                    , createdBy = ( User "Jack", 2 )
                    , assignedTo = Just (User "Alice")
                    , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                    }
                    |> assignTicketTo (User "Moss")
                    |> Expect.equal
                        (Ticket
                            { status = Closed
                            , createdBy = ( User "Jack", 2 )
                            , assignedTo = Just (User "Moss")
                            , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                            }
                        )
        , test "unsuccesfulfy assign archived, unassigned ticket to Roy" <|
            \() ->
                Ticket
                    { status = Archived
                    , createdBy = ( User "John", 1 )
                    , assignedTo = Nothing
                    , comments = []
                    }
                    |> assignTicketTo (User "Roy")
                    |> Expect.equal
                        (Ticket
                            { status = Archived
                            , createdBy = ( User "John", 1 )
                            , assignedTo = Nothing
                            , comments = []
                            }
                        )
        , test "unsuccesfulfy assign archived, assigned ticket to Moss" <|
            \() ->
                Ticket
                    { status = Archived
                    , createdBy = ( User "Jack", 2 )
                    , assignedTo = Just (User "Alice")
                    , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                    }
                    |> assignTicketTo (User "Moss")
                    |> Expect.equal
                        (Ticket
                            { status = Archived
                            , createdBy = ( User "Jack", 2 )
                            , assignedTo = Just (User "Alice")
                            , comments = [ ( User "Jack", "ping?" ), ( User "Alice", "pong!" ) ]
                            }
                        )
        ]
