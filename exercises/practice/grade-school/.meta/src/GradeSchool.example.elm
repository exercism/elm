module GradeSchool exposing (Grade, Result(..), School, Student, addStudent, allStudents, emptySchool, studentsInGrade)

import Dict exposing (..)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Int (List Student)


type Result
    = Added
    | Duplicate


emptySchool : School
emptySchool =
    Dict.empty


addStudent : Grade -> Student -> School -> ( Result, School )
addStudent grade student school =
    if List.member student (allStudents school) then
        ( Duplicate, school )

    else
        ( Added, Dict.insert grade (List.sort (student :: studentsInGrade grade school)) school )


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    case Dict.get grade school of
        Just list ->
            list

        Nothing ->
            []


allStudents : School -> List Student
allStudents school =
    Dict.toList school
        -- Dict.toList returns the elements sorted by key
        |> List.concatMap Tuple.second
