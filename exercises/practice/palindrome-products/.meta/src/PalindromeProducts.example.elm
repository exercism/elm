module PalindromeProducts exposing (largest, smallest)

import Array exposing (Array)
import Set


type alias PalindromeProduct =
    { value : Int
    , factors : List ( Int, Int )
    }


smallest : Int -> Int -> Result String (Maybe PalindromeProduct)
smallest min max =
    if min > max then
        Err "min must be <= max"

    else
        let
            initQueue =
                new (\( i, j ) -> i * j) (<=)
                    |> insert ( min, min )

            traverse queue visited =
                case pop queue of
                    Nothing ->
                        Ok Nothing

                    Just ( ( i, j ), product, poppedQueue ) ->
                        if isPalindrome product then
                            popUntilDifferent { value = product, factors = [ ( i, j ) ] } poppedQueue

                        else if j > max then
                            traverse poppedQueue visited

                        else
                            let
                                newVisited =
                                    visited |> Set.insert ( i, j + 1 ) |> Set.insert ( i + 1, j + 1 )

                                newQueue =
                                    [ ( i, j + 1 ), ( i + 1, j + 1 ) ] |> List.filter (\pair -> not (Set.member pair visited)) |> List.foldl insert poppedQueue
                            in
                            traverse newQueue newVisited
        in
        traverse initQueue Set.empty


largest : Int -> Int -> Result String (Maybe PalindromeProduct)
largest min max =
    if min > max then
        Err "min must be <= max"

    else
        let
            initQueue =
                new (\( i, j ) -> i * j) (>)
                    |> insert ( max, max )

            traverse queue visited =
                case pop queue of
                    Nothing ->
                        Ok Nothing

                    Just ( ( i, j ), product, poppedQueue ) ->
                        if isPalindrome product then
                            popUntilDifferent { value = product, factors = [ ( i, j ) ] } poppedQueue

                        else if i < min then
                            traverse poppedQueue visited

                        else
                            let
                                neighbors =
                                    [ ( i - 1, j ), ( i - 1, j - 1 ) ]

                                newVisited =
                                    List.foldl Set.insert visited neighbors

                                newQueue =
                                    neighbors
                                        |> List.filter (\pair -> not (Set.member pair visited))
                                        |> List.foldl insert poppedQueue
                            in
                            traverse newQueue newVisited
        in
        traverse initQueue Set.empty


isPalindrome : Int -> Bool
isPalindrome n =
    let
        string =
            String.fromInt n
    in
    string == String.reverse string


popUntilDifferent : PalindromeProduct -> PriorityQueue ( Int, Int ) -> Result String (Maybe PalindromeProduct)
popUntilDifferent product queue =
    case pop queue of
        Nothing ->
            Ok (Just { product | factors = List.sort product.factors })

        Just ( pair, value, newQueue ) ->
            if value == product.value then
                popUntilDifferent { product | factors = pair :: product.factors } newQueue

            else
                Ok (Just { product | factors = List.sort product.factors })



-- Priority Queue


type alias PriorityQueue a =
    { leq : Int -> Int -> Bool
    , toPriority : a -> Int
    , heap : Heap a
    }


type alias Heap a =
    Array ( a, Int )


new : (a -> Int) -> (Int -> Int -> Bool) -> PriorityQueue a
new toPriority leq =
    PriorityQueue leq toPriority Array.empty


insert : a -> PriorityQueue a -> PriorityQueue a
insert a ({ leq, toPriority, heap } as queue) =
    { queue | heap = insertHeap leq a (toPriority a) heap }


insertHeap : (Int -> Int -> Bool) -> a -> Int -> Heap a -> Heap a
insertHeap leq a p heap =
    bubbleUp leq (Array.length heap) (Array.push ( a, p ) heap)


bubbleUp : (Int -> Int -> Bool) -> Int -> Heap a -> Heap a
bubbleUp leq index heap =
    let
        parentIndex =
            (index - 1) // 2
    in
    case ( Array.get index heap, Array.get parentIndex heap ) of
        ( Just ( newA, newP ), Just ( parentA, parentP ) ) ->
            if index > 0 && leq newP parentP then
                bubbleUp leq
                    parentIndex
                    (heap
                        |> Array.set index ( parentA, parentP )
                        |> Array.set parentIndex ( newA, newP )
                    )

            else
                heap

        _ ->
            heap


pop : PriorityQueue a -> Maybe ( a, Int, PriorityQueue a )
pop ({ leq, heap } as queue) =
    case Array.get 0 heap of
        Nothing ->
            Nothing

        Just ( aTop, pTop ) ->
            let
                newHeap =
                    case Array.get (Array.length heap - 1) heap of
                        Nothing ->
                            heap

                        Just ( a, p ) ->
                            heap
                                |> Array.set 0 ( a, p )
                                |> Array.slice 0 (Array.length heap - 1)
                                |> bubbleDown leq 0
            in
            Just ( aTop, pTop, { queue | heap = newHeap } )


bubbleDown : (Int -> Int -> Bool) -> Int -> Heap a -> Heap a
bubbleDown leq index heap =
    let
        leftIndex =
            index * 2 + 1

        rightIndex =
            index * 2 + 2
    in
    case ( Array.get index heap, Array.get leftIndex heap, Array.get rightIndex heap ) of
        ( Just ( a, p ), Just ( leftA, leftP ), Nothing ) ->
            if leq p leftP then
                heap

            else
                heap |> Array.set index ( leftA, leftP ) |> Array.set leftIndex ( a, p )

        ( Just ( a, p ), Just ( leftA, leftP ), Just ( rightA, rightP ) ) ->
            if leq p leftP && leq p rightP then
                heap

            else if leq leftP rightP then
                bubbleDown leq leftIndex (heap |> Array.set index ( leftA, leftP ) |> Array.set leftIndex ( a, p ))

            else
                bubbleDown leq rightIndex (heap |> Array.set index ( rightA, rightP ) |> Array.set rightIndex ( a, p ))

        _ ->
            heap
