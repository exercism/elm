module GradeSchool exposing (addStudent, allStudents, empty, studentsInGrade)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Int (List Student)


empty : School
empty =
    Debug.crash "Please implement this function"


addStudent : Grade -> Student -> School -> School
addStudent grade student school =
    Debug.crash "Please implement this function"


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    Debug.crash "Please implement this function"


allStudents : School -> List ( Grade, List Student )
allStudents school =
    Debug.crash "Please implement this function"
