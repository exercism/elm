module CustomSet exposing (diff, disjoint, empty, equal, fromList, insert, intersect, isEmpty, member, subset, toList, union)


type Set
    = Nil
    | Node Int Set Set


empty : Set
empty =
    Nil


insert : Int -> Set -> Set
insert element set =
    case set of
        Nil ->
            Node element Nil Nil

        Node x left right ->
            case compare element x of
                EQ ->
                    set

                LT ->
                    Node x (insert element left) right

                GT ->
                    Node x left (insert element right)


toList : Set -> List Int
toList set =
    case set of
        Nil ->
            []

        Node x left right ->
            toList left ++ x :: toList right


fromList : List Int -> Set
fromList =
    List.foldl insert Nil


isEmpty : Set -> Bool
isEmpty set =
    case set of
        Nil ->
            True

        _ ->
            False


member : Int -> Set -> Bool
member element set =
    case set of
        Nil ->
            False

        Node x left right ->
            case compare element x of
                EQ ->
                    True

                LT ->
                    member element left

                GT ->
                    member element right


equal : Set -> Set -> Bool
equal set1 set2 =
    case ( set1, set2 ) of
        ( Nil, Nil ) ->
            True

        ( Node x1 left right, _ ) ->
            let
                ( l, x1Equalsx2, r ) =
                    splitAt x1 set2
            in
            x1Equalsx2 && equal l left && equal r right

        _ ->
            False


union : Set -> Set -> Set
union set1 set2 =
    case ( set1, set2 ) of
        ( Nil, _ ) ->
            set2

        ( _, Nil ) ->
            set1

        ( Node x1 left right, _ ) ->
            let
                ( l, _, r ) =
                    splitAt x1 set2
            in
            Node x1 (union l left) (union r right)


intersect : Set -> Set -> Set
intersect set1 set2 =
    case ( set1, set2 ) of
        ( Nil, _ ) ->
            Nil

        ( _, Nil ) ->
            Nil

        ( Node x1 left right, _ ) ->
            let
                ( l, x1Equalx2, r ) =
                    splitAt x1 set2
            in
            if x1Equalx2 then
                Node x1 (intersect l left) (intersect r right)

            else
                union (intersect l left) (intersect r right)


diff : Set -> Set -> Set
diff set1 set2 =
    case ( set1, set2 ) of
        ( Nil, _ ) ->
            Nil

        ( _, Nil ) ->
            set1

        ( Node x1 left right, _ ) ->
            let
                ( l, x1Equalsx2, r ) =
                    splitAt x1 set2

                diffLeft =
                    diff left l

                diffRight =
                    diff right r
            in
            if x1Equalsx2 then
                union diffLeft diffRight

            else
                Node x1 diffLeft diffRight


subset : Set -> Set -> Bool
subset set1 set2 =
    diff set1 set2
        |> isEmpty


disjoint : Set -> Set -> Bool
disjoint set1 set2 =
    intersect set1 set2
        |> isEmpty


splitAt : Int -> Set -> ( Set, Bool, Set )
splitAt split set =
    case set of
        Nil ->
            ( Nil, False, Nil )

        Node x left right ->
            case ( compare split x, left, right ) of
                ( EQ, _, _ ) ->
                    ( left, True, right )

                ( LT, Nil, _ ) ->
                    ( Nil, False, set )

                ( LT, _, _ ) ->
                    let
                        ( l, isMember, r ) =
                            splitAt split left
                    in
                    ( l, isMember, Node x r right )

                ( GT, _, Nil ) ->
                    ( set, False, Nil )

                ( GT, _, _ ) ->
                    let
                        ( l, isMember, r ) =
                            splitAt split right
                    in
                    ( Node x left l, isMember, r )
