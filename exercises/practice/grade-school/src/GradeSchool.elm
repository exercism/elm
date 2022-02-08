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
    Debug.todo "Please implement emptySchool"


addStudent : Grade -> Student -> School -> ( Result, School )
addStudent grade student school =
    Debug.todo "Please implement addStudent"


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    Debug.todo "Please implement studentsInGrade"


allStudents : School -> List Student
allStudents school =
    Debug.todo "Please implement allStudents"
