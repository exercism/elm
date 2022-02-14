# Instructions

You are part of the IT helpdesk, and you want to improve the ticketing system to be more efficient and provide statistics for your manager.

A ticket has a status (new, in progress...), a creator (identified by a username and an employee ID), can be assigned to an IT employee and contains a history of comments.

Here are four tasks that wil improve your current ticketing system.

## 1. Detect empty comments

Empty comments clutter the interface and bring no information, you want to filter them out.

Define a helper function `emptyComment` that take a user/comment pair and return `True` for empty comments.

Use destructuring to extract the user and the comment directly in the function argument. Ignore the user since you don't need that information.

```elm
emptyComment ( User "Alice", "" )
-- => True
```

## 2. Count the number of comments from the creator

Your manager wants to have statistics about user involvement in the ticket process. 
She asks you to check how many comments are added by the ticket creator.

Define `numberOfCreatorComments` that takes a ticket and return the number of comments added by the ticket creator.

Use destructuring in the function argument to extract the record from the `Ticket` type, at the same time as the fields you need from the record. 
Then, destructure the `createdBy` in a `let` binding so you can count the relevant comments.
Use `List` functions to do the count and use destructuring in the function argument of an anonymous function to seperate the user/comment pair.

```elm
numberOfCreatorComments
numberOfCreatorComments
    (Ticket
        { status = Closed
        , createdBy = ( User "Chiaki", 1 )
        , assignedTo = Nothing
        , comments = [ ( User "Chiaki", "Never mind, fixed it." ) ]
        }
    )
-- => 1
```

## 3. Detect tickets assigned to the Dev Team

Some tickets have to be escalated to Alice, Bob, or Charlie from the Dev Team.
It's important to keep an eye on those to make sure they are making progress.

Define a helper function `assignedToDevTeam` that checks if a ticket is assigned to one of the Dev Team members.

Use destructuring in the function argument to extract the record from the `Ticket` type as well as the field you need.
Then, use a single `case` statement to check if the ticket is assigned to Alice, Bob, or Charlie using recursive pattern matching to extract their usernames and litteral pattern matching to match them. 

```elm
assignedToDevTeam
    (Ticket
        { status = InProgress
        , createdBy = ( User "Bill", 2 )
        , assignedTo = Just (User "Alice")
        , comments = [ ( User "Bill", "What's an 'undefined'?" ) ]
        }
    )
-- => True
```

## 4. Assign tickets to IT employees

Sometimes a bunch tickets need to be reassigned to other IT employees.

Define a function `assignTicketTo` to help you do that. The function receives two arguments: a user to assign the ticket to and a ticket. 
If the status of the ticket is `New`, assign it to the new user and change the status to `InProgress`. 
For other statuses, simply reassign the ticket to the new users, except for tickets with the status `Archived` that should not be modified at all.

Use destructuring in the function argument to extract the record from the `Ticket` type as well as the field you need, and also use the `as` keyword to capture the whole record as it is. 
Use a single `case` statement to pattern match the status and return the appropriate ticket, created from modifying the original record you captured with the `as` keyword.

```elm
assignTicketTo (User "Danny")
    (Ticket
        { status = New
        , createdBy = ( User "Jesse", 3 )
        , assignedTo = Just (User "Alice")
        , comments = [ ( User "Jesse", "I've been waiting for 6 months!!" ) ]
        }
    )
-- => Ticket
--        { status = InProgress
--        , createdBy = ( User "Jesse", 3 )
--        , assignedTo = Just (User "Danny")
--        , comments = [ ( User "Jesse", "I've been waiting for 6 months!!" ) ]
--        }
```