module GradeSchool exposing (..)

import Dict exposing (..)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Int (List Student)


empty : School
empty =
    Dict.empty


addStudent : Grade -> Student -> School -> School
addStudent grade student school =
    Dict.insert grade (List.sort (student :: studentsInGrade grade school)) school


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    case Dict.get grade school of
        Just list ->
            list

        Nothing ->
            []


allStudents : School -> List ( Grade, List Student )
allStudents school =
    Dict.toList school |> List.sortBy Tuple.first
