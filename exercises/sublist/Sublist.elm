module Sublist exposing (ListComparison(..), sublist, version)


version : Int
version =
    2


type ListComparison
    = Equal
    | Superlist
    | Sublist
    | Unequal


sublist : List a -> List a -> ListComparison
sublist alist blist =
    Debug.crash "Please implement this function"
