module Tests exposing (tests)

import Expect
import GradeSchool exposing (Grade, Result(..), School, Student, addStudent, allStudents, emptySchool, studentsInGrade)
import Test exposing (..)


buildSchoolwithStudents : List ( Student, Grade ) -> ( List Result, School )
buildSchoolwithStudents students =
    let
        insert ( student, grade ) ( results, school ) =
            addStudent grade student school
                |> Tuple.mapFirst (\result -> result :: results)
    in
    List.foldl insert ( [], emptySchool ) students
        |> Tuple.mapFirst List.reverse


tests : Test
tests =
    describe "GradeSchool"
        [ test "Roster is empty when no student is added" <|
            \() -> Expect.equal [] (allStudents emptySchool)
        , skip <|
            test "Add a student" <|
                \() ->
                    addStudent 2 "Aimee" emptySchool
                        |> Tuple.first
                        |> Expect.equal Added
        , skip <|
            test "Student is added to the roster" <|
                \() ->
                    addStudent 2 "Aimee" emptySchool
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Aimee" ]
        , skip <|
            test "Adding multiple students in the same grade in the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                        |> Tuple.first
                        |> Expect.equal [ Added, Added, Added ]
        , skip <|
            test "Multiple students in the same grade are added to the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Blair", "James", "Paul" ]
        , skip <|
            test "Cannot add student to same grade in the roster more than once" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                        |> Tuple.first
                        |> Expect.equal [ Added, Added, Duplicate, Added ]
        , skip <|
            test "Student not added to same grade in the roster more than once" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Blair", "James", "Paul" ]
        , skip <|
            test "Adding students in multiple grades" <|
                \() ->
                    buildSchoolwithStudents [ ( "Chelsea", 3 ), ( "Logan", 7 ) ]
                        |> Tuple.first
                        |> Expect.equal [ Added, Added ]
        , skip <|
            test "Students in multiple grades are added to the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Chelsea", 3 ), ( "Logan", 7 ) ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Chelsea", "Logan" ]
        , skip <|
            test "Cannot add same student to multiple grades in the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                        |> Tuple.first
                        |> Expect.equal [ Added, Added, Duplicate, Added ]
        , skip <|
            test "Student not added to multiple grades in the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Blair", "James", "Paul" ]
        , skip <|
            test "Students are sorted by grades in the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Jim", 3 ), ( "Peter", 2 ), ( "Anna", 1 ) ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Anna", "Peter", "Jim" ]
        , skip <|
            test "Students are sorted by name in the roster" <|
                \() ->
                    buildSchoolwithStudents [ ( "Peter", 2 ), ( "Zoe", 2 ), ( "Alex", 2 ) ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Alex", "Peter", "Zoe" ]
        , skip <|
            test "Students are sorted by grades and then by name in the roster" <|
                \() ->
                    buildSchoolwithStudents
                        [ ( "Peter", 2 )
                        , ( "Anna", 1 )
                        , ( "Barb", 1 )
                        , ( "Zoe", 2 )
                        , ( "Alex", 2 )
                        , ( "Jim", 3 )
                        , ( "Charlie", 1 )
                        ]
                        |> Tuple.second
                        |> allStudents
                        |> Expect.equal [ "Anna", "Barb", "Charlie", "Alex", "Peter", "Zoe", "Jim" ]
        , skip <|
            test "Grade is empty if no students in the roster" <|
                \() ->
                    Expect.equal [] (studentsInGrade 1 emptySchool)
        , skip <|
            test "Grade is empty if no students in that grade" <|
                \() ->
                    buildSchoolwithStudents [ ( "Peter", 2 ), ( "Zoe", 2 ), ( "Alex", 2 ), ( "Jim", 3 ) ]
                        |> Tuple.second
                        |> studentsInGrade 1
                        |> Expect.equal []
        , skip <|
            test "Student not added to same grade more than once" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                        |> Tuple.second
                        |> studentsInGrade 2
                        |> Expect.equal [ "Blair", "James", "Paul" ]
        , skip <|
            test "Student not added to multiple grades" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                        |> Tuple.second
                        |> studentsInGrade 2
                        |> Expect.equal [ "Blair", "James" ]
        , skip <|
            test "Student not added to other grade for multiple grades" <|
                \() ->
                    buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                        |> Tuple.second
                        |> studentsInGrade 3
                        |> Expect.equal [ "Paul" ]
        , skip <|
            test "Students are sorted by name in a grade" <|
                \() ->
                    buildSchoolwithStudents [ ( "Franklin", 5 ), ( "Bradley", 5 ), ( "Jeff", 1 ) ]
                        |> Tuple.second
                        |> studentsInGrade 5
                        |> Expect.equal [ "Bradley", "Franklin" ]
        ]
