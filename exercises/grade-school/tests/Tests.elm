module Tests exposing (tests)

import Expect
import GradeSchool exposing (addStudent, allStudents, studentsInGrade)
import Test exposing (..)


tests : Test
tests =
    describe "GradeSchool"
        [ test "add student" <|
            \() ->
                Expect.equal [ "Aimee" ]
                    (GradeSchool.empty
                        |> addStudent 2 "Aimee"
                        |> studentsInGrade 2
                    )
        , skip <|
            test "add more students in same class" <|
                \() ->
                    Expect.equal [ "Blair", "James", "Paul" ]
                        (GradeSchool.empty
                            |> addStudent 2 "James"
                            |> addStudent 2 "Blair"
                            |> addStudent 2 "Paul"
                            |> studentsInGrade 2
                        )
        , skip <|
            test "add students to different grades" <|
                \() ->
                    Expect.equal [ [ "Chelsea" ], [ "Logan" ] ]
                        (let
                            school =
                                GradeSchool.empty
                                    |> addStudent 3 "Chelsea"
                                    |> addStudent 7 "Logan"
                         in
                         [ studentsInGrade 3 school, studentsInGrade 7 school ]
                        )
        , skip <|
            test "get students in a grade" <|
                \() ->
                    Expect.equal [ "Bradley", "Franklin" ]
                        (GradeSchool.empty
                            |> addStudent 5 "Franklin"
                            |> addStudent 5 "Bradley"
                            |> addStudent 1 "Jeff"
                            |> studentsInGrade 5
                        )
        , skip <|
            test "get all students in the school" <|
                \() ->
                    Expect.equal [ ( 1, [ "Anna", "Barb", "Charlie" ] ), ( 2, [ "Alex", "Peter", "Zoe" ] ), ( 3, [ "Jim" ] ) ]
                        (GradeSchool.empty
                            |> addStudent 2 "Peter"
                            |> addStudent 1 "Anna"
                            |> addStudent 1 "Barb"
                            |> addStudent 2 "Zoe"
                            |> addStudent 2 "Alex"
                            |> addStudent 3 "Jim"
                            |> addStudent 1 "Charlie"
                            |> allStudents
                        )
        , skip <|
            test "get students in a non-existent grade" <|
                \() -> Expect.equal [] (studentsInGrade 1 GradeSchool.empty)
        ]
