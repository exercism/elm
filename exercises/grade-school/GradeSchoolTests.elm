module Main exposing (..)

import ElmTest exposing (..)
import GradeSchool exposing (addStudent, studentsInGrade, allStudents)


tests : Test
tests =
    suite "GradeSchool"
        [ test "add student"
            (assertEqual [ "Aimee" ]
                (GradeSchool.empty
                    |> addStudent 2 "Aimee"
                    |> studentsInGrade 2
                )
            )
        , test "add more students in same class"
            (assertEqual [ "Blair", "James", "Paul" ]
                (GradeSchool.empty
                    |> addStudent 2 "James"
                    |> addStudent 2 "Blair"
                    |> addStudent 2 "Paul"
                    |> studentsInGrade 2
                )
            )
        , test "add students to different grades"
            (assertEqual [ [ "Chelsea" ], [ "Logan" ] ]
                (let
                    school =
                        GradeSchool.empty
                            |> addStudent 3 "Chelsea"
                            |> addStudent 7 "Logan"
                 in
                    [ studentsInGrade 3 school, studentsInGrade 7 school ]
                )
            )
        , test "get students in a grade"
            (assertEqual [ "Bradley", "Franklin" ]
                (GradeSchool.empty
                    |> addStudent 5 "Franklin"
                    |> addStudent 5 "Bradley"
                    |> addStudent 1 "Jeff"
                    |> studentsInGrade 5
                )
            )
        , test "get all students in the school"
            (assertEqual [ ( 3, [ "Kyle" ] ), ( 4, [ "Christopher", "Jennifer" ] ), ( 6, [ "Kareem" ] ) ]
                (GradeSchool.empty
                    |> addStudent 4 "Jennifer"
                    |> addStudent 6 "Kareem"
                    |> addStudent 4 "Christopher"
                    |> addStudent 3 "Kyle"
                    |> allStudents
                )
            )
        , test "get students in a non-existent grade"
            (assertEqual [] (studentsInGrade 1 GradeSchool.empty))
        ]


main : Program Never
main =
    runSuite tests
