# Instructions

In this exercise you're going to write a generic (/ magical!) TreasureChest, to store some treasure.
Sharp eyed students will have noticed that the previous `TreasureChest` wasn't that secure!
If you used the `getTreasure` function, then you had to supply the password, but you could still simply destructure the `TreasureChest` type to get the treasure, without having to know the password.
Even worse, you could even retrieve the password in the same way!
Let's fix that by using an Opaque Type.

## 1. Define the SecureTreasureChest generic custom type

Define a `SecureTreasureChest` custom type with a single variant.

The variant should have an associated `String` value, which will be used to store the password of the treasure chest.

The variant should also have an associate generic value, which will be used to store the treasure.
This value is generic so that the treasure can be anything.

You should expose the `SecureTreasureChest` type, but not the variant. This makes `SecureTreasureChest` an Opaque type, and means that you can no longer use destructing to get the password or the treasure.

## 2. Define the createTreasure function

This function should take two parameters

- a `String` (for the password)
- a generic type (for the treasure)

The function should return a `Maybe SecureTreasureChest` (for now always use `Just`).

Expose this function, so that other modules are able to create instances of `SecureTreasureChest`.

## 3. Define the getTreasure function

This function should take two parameters

- a `String` (for the password)
- a `TreasureChest` generic custom type

This function should check the provided password attempt against the `String` in the `TreasureChest`.

The function should return a `Maybe`.

If the passwords match then return `Just` with the generic value from the `TreasureChest` (the treasure!)

If the passwords do not match then return `Nothing`.

Expose this function, so that other modules are able to get the treasure from a `SecureTreasureChest`, as long as they supply the correct password.

## 4. Impose a minimum length for the password

Owasp recommends that [passwords should be at least 8 characters long][owasp-password-length], so lets use the [Parse, don't validate][parse-dont-validate] pattern to enforce this invariant.

Modify the `createTreasure` function, so that if the password is less than 8 characters long, it returns `Nothing`, and otherwise it returns `Just SecureTreasureChest`.


[owasp-password-length][https://cheatsheetseries.owasp.org/cheatsheets/Authentication_Cheat_Sheet.html#implement-proper-password-strength-controls]
