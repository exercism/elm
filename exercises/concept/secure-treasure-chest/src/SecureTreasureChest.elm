module SecureTreasureChest exposing (..)

-- One. define a single variant generic SecureTreasureChest custom type with associated data:
--  - a String (for a password)
--  - a generic (for the treasure)
-- expose the type, but not the variant, which will make an Opaque Type


type SecureTreasureChest
    = TODO



-- Two. define createTreasure, with a type annotation, with two parameters:
--  - a String (for the password)
--  - a generic (for the treasure)
-- and returns a Maybe SecureTreasureChest (always return Just for now)
-- expose the function


createTreasure password treasure =
    Debug.todo "Please implement createTreasure"



-- Three. define getTreasure, with a type annotation, with two parameters:
--  - a String (for the passwordAttempt)
--  - a SecureTreasureChest custom type
-- and returns:
--  - if the passwordAttempt does not match the String in the SecureTreasureChest
--   - Nothing
--  - if the passwordAttempt matches the String in the SecureTreasureChest
--   - Just treasure (where treasure is the generic in the SecureTreasureChest)
-- expose the function


getTreasure passwordAttempt secureTreasureChest =
    Debug.todo "Please implement getTreasure"



-- Four. update createTreasure, so that it checks the length of the password.
-- If the password is long enough, return Just SecureTreasureChest,
-- otherwise return Nothing
