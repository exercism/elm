module GradeSchool exposing (addStudent, allStudents, empty, studentsInGrade)

import Dict exposing (Dict)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Grade (List Student)


empty : School
empty =
    Debug.todo "Please implement this function"


addStudent : Grade -> Student -> School -> School
addStudent grade student school =
    Debug.todo "Please implement this function"


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    Debug.todo "Please implement this function"


allStudents : School -> List ( Grade, List Student )
allStudents school =
    Debug.todo "Please implement this function"
