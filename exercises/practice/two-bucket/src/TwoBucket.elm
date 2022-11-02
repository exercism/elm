module TwoBucket exposing (BucketNumber(..), measure)


type BucketNumber
    = One
    | Two


type alias State =
    { moves : Int, bucketOne : Int, bucketTwo : Int }


measure : Int -> Int -> Int -> BucketNumber -> Maybe State
measure bucketOneSize bucketTwoSize goal startBucket =
    Debug.todo "Please implement measure"
