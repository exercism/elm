module PalindromeProducts exposing (largest, smallest)


type alias PalindromeProduct =
    { value : Int
    , factors : List ( Int, Int )
    }


smallest : Int -> Int -> Result String (Maybe PalindromeProduct)
smallest min max =
    Debug.todo "Please implement smallest"


largest : Int -> Int -> Result String (Maybe PalindromeProduct)
largest min max =
    Debug.todo "Please implement largest"
