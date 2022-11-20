module TreasureChest exposing (..)

{-|

1.  define a single variant generic TreasureChest custom type with associated data:
      - a String (for a password)

      - a generic (for the treasure)

-}


{-|

1.  define getTreasure

-}
getTreasure passwordAttempt =
    Debug.todo """
define getTreasure, with a type annotation, with two parameters:
- a String (for the passwordAttempt)
- a TreasureChest custom type
 and returns:
- if the passwordAttempt does not match the String in the TreasureChest
  - Nothing
- if the passwordAttempt matches the String in the TreasureChest
  - Just treasure (where treasure is the generic in the TreasureChest)
"""
