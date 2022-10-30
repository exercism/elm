module CustomSet exposing (diff, disjoint, empty, equal, fromList, insert, intersect, isEmpty, member, subset, toList, union)


type Set
    = Todo Int


empty : Set
empty =
    Debug.todo "Please implement empty"


insert : Int -> Set -> Set
insert element set =
    Debug.todo "Please implement insert"


toList : Set -> List Int
toList set =
    Debug.todo "Please implement toList"


fromList : List Int -> Set
fromList elements =
    Debug.todo "Please implement fromList"


isEmpty : Set -> Bool
isEmpty set =
    Debug.todo "Please implement isEmpty"


member : Int -> Set -> Bool
member element set =
    Debug.todo "Please implement member"


equal : Set -> Set -> Bool
equal set1 set2 =
    Debug.todo "Please implement equal"


union : Set -> Set -> Set
union set1 set2 =
    Debug.todo "Please implement union"


intersect : Set -> Set -> Set
intersect set1 set2 =
    Debug.todo "Please implement intersect"


diff : Set -> Set -> Set
diff set1 set2 =
    Debug.todo "Please implement diff"


subset : Set -> Set -> Bool
subset set1 set2 =
    Debug.todo "Please implement subset"


disjoint : Set -> Set -> Bool
disjoint set1 set2 =
    Debug.todo "Please implement disjoint"
