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
    Debug.todo "Please implement this function"


addStudent : Grade -> Student -> School -> ( Result, School )
addStudent grade student school =
    Debug.todo "Please implement this function"


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    Debug.todo "Please implement this function"


allStudents : School -> List Student
allStudents school =
    Debug.todo "Please implement this function"
