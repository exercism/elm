module Tests exposing (tests)

import Expect
import GradeSchool exposing (Grade, Result(..), School, Student, addStudent, allStudents, emptySchool, studentsInGrade)
import Test exposing (..)


buildSchoolwithStudents : List ( Student, Grade ) -> ( List Result, School )
buildSchoolwithStudents students =
    let
        ( reversedResults, finalSchool ) =
            List.foldl insert ( [], emptySchool ) students

        insert ( student, grade ) ( results, school ) =
            let
                ( result, newSchool ) =
                    addStudent grade student school
            in
            ( result :: results, newSchool )
    in
    ( List.reverse reversedResults, finalSchool )


tests : Test
tests =
    describe "GradeSchool"
        [ test "Roster is empty when no student is added" <|
            \() -> Expect.equal [] (allStudents emptySchool)
        , test "Add a student" <|
            \() ->
                let
                    ( result, _ ) =
                        addStudent 2 "Aimee" emptySchool
                in
                Expect.equal Added result
        , test "Student is added to the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Aimee", 2 ) ]
                in
                Expect.equal [ "Aimee" ] (allStudents school)
        , test "Adding multiple students in the same grade in the roster" <|
            \() ->
                let
                    ( results, _ ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                in
                Expect.equal [ Added, Added, Added ] results
        , test "Multiple students in the same grade are added to the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                in
                Expect.equal [ "Blair", "James", "Paul" ] (allStudents school)
        , test "Cannot add student to same grade in the roster more than once" <|
            \() ->
                let
                    ( results, _ ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                in
                Expect.equal [ Added, Added, Duplicate, Added ] results
        , test "Student not added to same grade in the roster more than once" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                in
                Expect.equal [ "Blair", "James", "Paul" ] (allStudents school)
        , test "Adding students in multiple grades" <|
            \() ->
                let
                    ( results, _ ) =
                        buildSchoolwithStudents [ ( "Chelsea", 3 ), ( "Logan", 7 ) ]
                in
                Expect.equal [ Added, Added ] results
        , test "Students in multiple grades are added to the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Chelsea", 3 ), ( "Logan", 7 ) ]
                in
                Expect.equal [ "Chelsea", "Logan" ] (allStudents school)
        , test "Cannot add same student to multiple grades in the roster" <|
            \() ->
                let
                    ( results, _ ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                in
                Expect.equal [ Added, Added, Duplicate, Added ] results
        , test "Student not added to multiple grades in the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                in
                Expect.equal [ "Blair", "James", "Paul" ] (allStudents school)
        , test "Students are sorted by grades in the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Jim", 3 ), ( "Peter", 2 ), ( "Anna", 1 ) ]
                in
                Expect.equal [ "Anna", "Peter", "Jim" ] (allStudents school)
        , test "Students are sorted by name in the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Peter", 2 ), ( "Zoe", 2 ), ( "Alex", 2 ) ]
                in
                Expect.equal [ "Alex", "Peter", "Zoe" ] (allStudents school)
        , test "Students are sorted by grades and then by name in the roster" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents
                            [ ( "Peter", 2 )
                            , ( "Anna", 1 )
                            , ( "Barb", 1 )
                            , ( "Zoe", 2 )
                            , ( "Alex", 2 )
                            , ( "Jim", 3 )
                            , ( "Charlie", 1 )
                            ]
                in
                Expect.equal [ "Anna", "Barb", "Charlie", "Alex", "Peter", "Zoe", "Jim" ] (allStudents school)
        , test "Grade is empty if no students in the roster" <|
            \() ->
                Expect.equal [] (studentsInGrade 1 emptySchool)
        , test "Grade is empty if no students in that grade" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Peter", 2 ), ( "Zoe", 2 ), ( "Alex", 2 ), ( "Jim", 3 ) ]
                in
                Expect.equal [] (studentsInGrade 1 school)
        , test "Student not added to same grade more than once" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 2 ), ( "Paul", 2 ) ]
                in
                Expect.equal [ "Blair", "James", "Paul" ] (studentsInGrade 2 school)
        , test "Student not added to multiple grades" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                in
                Expect.equal [ "Blair", "James" ] (studentsInGrade 2 school)
        , test "Student not added to other grade for multiple grades" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Blair", 2 ), ( "James", 2 ), ( "James", 3 ), ( "Paul", 3 ) ]
                in
                Expect.equal [ "Paul" ] (studentsInGrade 3 school)
        , test "Students are sorted by name in a grade" <|
            \() ->
                let
                    ( _, school ) =
                        buildSchoolwithStudents [ ( "Franklin", 5 ), ( "Bradley", 5 ), ( "Jeff", 1 ) ]
                in
                Expect.equal [ "Bradley", "Franklin" ] (studentsInGrade 5 school)
        ]
