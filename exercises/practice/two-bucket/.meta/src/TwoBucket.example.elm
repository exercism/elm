module TwoBucket exposing (BucketNumber(..), measure)

import Set exposing (Set)


type BucketNumber
    = One
    | Two


type alias State =
    { moves : Int, bucketOne : Int, bucketTwo : Int }


type alias Params =
    { goal : Int, bucketOneSize : Int, bucketTwoSize : Int }


type alias History =
    Set ( Int, Int )


measure : Int -> Int -> Int -> BucketNumber -> Maybe State
measure bucketOneSize bucketTwoSize goal startBucket =
    let
        params =
            Params goal bucketOneSize bucketTwoSize

        ( initialState, forbiddenState ) =
            case startBucket of
                One ->
                    ( State 1 bucketOneSize 0, Set.singleton ( 0, bucketTwoSize ) )

                Two ->
                    ( State 1 0 bucketTwoSize, Set.singleton ( bucketOneSize, 0 ) )
    in
    step params forbiddenState [ initialState ]


step : Params -> History -> List State -> Maybe State
step ({ goal } as params) history states =
    case states of
        [] ->
            Nothing

        ({ bucketOne, bucketTwo } as state) :: rest ->
            if bucketOne == goal || bucketTwo == goal then
                Just state

            else if Set.member ( bucketOne, bucketTwo ) history then
                step params history rest

            else
                let
                    newHistory =
                        Set.insert ( bucketOne, bucketTwo ) history

                    nextStates =
                        actions params state
                in
                step params newHistory (rest ++ nextStates)


actions : Params -> State -> List State
actions { bucketOneSize, bucketTwoSize } { moves, bucketOne, bucketTwo } =
    uniqueStates
        [ -- fill buckets
          State (moves + 1) bucketOneSize bucketTwo
        , State (moves + 1) bucketOne bucketTwoSize

        -- empty buckets
        , State (moves + 1) 0 bucketTwo
        , State (moves + 1) bucketOne 0

        -- pour bucket one into two
        , State (moves + 1)
            (max 0 (bucketOne - (bucketTwoSize - bucketTwo)))
            (min bucketTwoSize (bucketTwo + bucketOne))

        -- pour bucket two into one
        , State (moves + 1)
            (min bucketOneSize (bucketOne + bucketTwo))
            (max 0 (bucketTwo - (bucketOneSize - bucketOne)))
        ]


uniqueStates : List State -> List State
uniqueStates =
    List.map (\{ moves, bucketOne, bucketTwo } -> ( moves, bucketOne, bucketTwo ))
        >> Set.fromList
        >> Set.toList
        >> List.map (\( moves, bucketOne, bucketTwo ) -> State moves bucketOne bucketTwo)
