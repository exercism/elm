# Instructions

You, the Master of Evil, take great pride in the quality of the `TreasureChest`s found in your Evil dungeons all over the world.
It's not easy to keep up the quality, your dungeon managers keep messing up treasure making, so you decide to provide an Elm API to bend them to your Will.

There are two conditions on which you will not budge:
1. a `TreasureChest` should be protected by a secure password of at least 12 characters
2. in a specific dungeon, each `TreasureChest` should hold a unique treasure

Your dungeon managers will come up with a list of password/treasure suggestions, and only suitable `TreasureChest`s will be created.

Should the treasures be unique from the initial list, or from a filtered list of chests with secure passwords?
You don't mind that too much as long as your two conditions are met, you will expose the verification functions and it will be decided by the dungeon managers.

This makes the phantom type technique a great choice for the API.

## 1. Provide a placeholder for treasure chests

The `treasureChest` type and its companion `getTreasure` are already given, but you need to come up with a type for a chest suggestion.

Implement the `Chest` type, implement `makeChest` and fix the type signatures of `secureChest` and `uniqueTreasures`.
The type signatures of `makeChest` and `makeTreasureChest` are already provided as part of the requirements, do not modify them.

A `Chest` should hold the same data as a `TreasureChest` and should have two type arguments, one for `treasure` and a record phantom type for `conditions`.
Note that because `Chest` is using a phantom type, and should therefore be opaque to prevent its use anywhere outside of the `TreasureFactory` module.
In this case, it is not even exposed at all.

`secureChest` should take a `Chest` without specific conditions and return one wrapped in a `Maybe` that has the extra condition `securePassword : ()`.
`makeTreasureChest` should take a `List` of `Chest` without specific conditions and return a `List` of `Chest`, with the duplicates removed, and the extra condition `uniqueTreasure : ()` added.

~~~~exercism/note
Elm tests have access to exposed functions, but not to type signatures, it is therefore impossible for tests to verify that you are using the right signatures.
Of course, the strongest indication that you have the right signatures is to succeed in getting the module and tests to compile and run.
~~~~

## 2. Select secure chests

Once you have chests ready, you need to pick out the secure ones.

Implement `secureChest` that only return a `Just` variant for chests with a password of 12 or more characters.
The `Chest` that fulfill that conditions should have an extra `securePassword : ()` condition added to their phantom type.

## 3. Select unique treasures

Only the rarest of treasures should be allowed in a dungeon, even one copy makes a treasure look cheap.

Implement `uniqueTreasures` that takes a list of `Chest` and returns a list of the `Chest` that have a unique treasure in the input list.
If a treasure appears twice in the input, it shouldn't be in the output.
The input `Chest`s should not have specific conditions and output ones should have the extra condition `uniqueTreasure : ()` added.

## 4. Enjoy the final product

Enjoy the best of `TreasureChest`s that will be sure to attract adventurers like flies to honey.

Implement `makeTreasureChest` that takes a `Chest` that is both secure and unique and creates a `TreasureChest`.
Since `TreasureChest` is an opaque type, this will be the only way to create one, even lousy dungeon managers won't be able to mess it up.
