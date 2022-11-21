# Instructions

In this exercise you're going to write a generic (/ magical!) TreasureChest, to store some treasure.

## 1. Define the TreasureChest generic custom type

Define a `TreasureChest` custom type with a single variant.

The variant should have an associated `String` value, which will be used to store the password of the treasure chest.

The variant should also have an associate generic value, which will be used to store the treasure. This value is generic so that the treasure can be anything.

## 2. Define the getTreasure function

This function should take two parameters

- a `String` (for trying a password)
- a `TreasureChest` generic custom type

This function should check the provided password attempt against the `String` in the `TreasureChest`.

The function should return a `Maybe`.

If the passwords match then return `Just` with the generic value from the `TreasureChest` (the treasure!)

If the passwords do not match then return `Nothing`.
