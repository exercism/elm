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
    if alist == blist then
        Equal

    else if inList alist blist then
        Superlist

    else if inList blist alist then
        Sublist

    else
        Unequal


inList : List a -> List a -> Bool
inList alist blist =
    let
        getLastInList sublist_ =
            Maybe.withDefault [] (List.tail sublist_)
    in
    if List.length alist < List.length blist then
        False

    else if List.take (List.length blist) alist == blist then
        True

    else
        inList (getLastInList alist) blist
