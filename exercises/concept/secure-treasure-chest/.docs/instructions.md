# Instructions

In this exercise you're going to write a generic (/ magical!) `SecureTreasureChest`, to store some treasure.
Sharp eyed students will have noticed that the previous `TreasureChest` wasn't that secure!
If you used the `getTreasure` function, then you had to supply the password, but you could still simply destructure the `TreasureChest` type to get the treasure, without having to know the password.
Even worse, you could even retrieve the password in the same way!
Let's fix that by using an Opaque Type.

## 1. Define the Password opaque type, using the "Parse, don't validate" pattern

Define a `Password` custom type with a single variant.

The variant should have an associated `String` value, for the password.

You should expose the `Password` type, but not the variant.
This makes `Password` an Opaque type, and means that you can no longer use destructing to get the password.
It is not possible to test whether a type is Opaque or not, in production code, you would use [elm-review][elm-review] (a static analysis tool) to enforce it.

Define and expose a `createPassword` function, with a type definition, that takes a `String` and returns a `Maybe Password`.

Owasp recommends that [passwords should be at least 8 characters long][owasp-password-length], so lets use the [Parse, don't validate][parse-dont-validate] pattern to enforce this invariant.

If the password is less than 8 characters long, `createPassword` should return `Nothing`, otherwise it should return `Just Password`.

## 2. Expose SecureTreasureChest, but not it's variant

You should expose the `SecureTreasureChest` type, but not the variant.
This makes `SecureTreasureChest` an Opaque type, and means that you can no longer use destructuring to get the password or the treasure.

## 3. Define the createTreasure function

This function should take two parameters, and have a type definition.

- a generic type (for the treasure)
- a `Password` (for the password)

The function should return a `SecureTreasureChest`.

Expose this function, so that other modules are able to create instances of `SecureTreasureChest`.

## 4. Define the getTreasure function

This function should take two parameters, and have a type definition.

- a `String` (for the password)
- a `TreasureChest` generic custom type

This function should check the provided password attempt against the `Password` in the `SecureTreasureChest`.

The function should return a `Maybe`.

If the passwords match then return `Just` with the generic value from the `SecureTreasureChest` (the treasure!)

If the passwords do not match then return `Nothing`.

Expose this function, so that other modules are able to get the treasure from a `SecureTreasureChest`, as long as they supply the correct password.


[owasp-password-length][https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html#implement-proper-password-strength-controls]
[elm-review][https://package.elm-lang.org/packages/jfmengels/elm-review/latest/]
