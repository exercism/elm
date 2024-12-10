# Instructions

You, the Master of Evil, take great pride in the quality of the `TreasureChest`s found in your Evil dungeons all over the world.
It's not easy to keep up the quality, your dungeon managers keep messing up treasure making, so you decide to provide an Elm API to bend them to your Will.

There are two conditions on which you will not budge:
1. a `TreasureChest` should be protected by a secure password of at least 8 characters
2. in a specific dungeon, each `TreasureChest` should hold a unique treasure

Your dungeon managers will come up with a list of password/treasure suggestions, and only suitable `TreasureChest`s will be created.

With these criterion, there are two possible ways of creating secure chests from a list of suggestions: 
1. remove the ones with insecure passwords, then remove the ones with duplicate treasures
2. remove the ones with duplicate treasures, then remove the ones with insecure passwords

Those two might not give the same results (for example for `[("strong_password", GoldStatue), ("1234", GoldStatue)]`), but you don't mind either way, so you want to let the dungeon managers decide.

An API that leaves the users some choice, but still guarantees properties of the final result?
Sounds like a perfect fit for the phantom type technique!

## 1. Provide a placeholder for treasure chests

The `TreasureChest` type and its companion `getTreasure` are already given, but you need to come up with a type for a chest suggestion.

Implement the `Chest` type, implement `makeChest` and fix the type signatures of `secureChest` and `uniqueTreasures`.
The type signatures of `makeChest` and `makeTreasureChest` are already provided as part of the requirements, do not modify them.

A `Chest` should hold the same data as a `TreasureChest` and should have two type arguments, one for `treasure` and a record phantom type for `conditions`.
Note that because `Chest` is using a phantom type, and should therefore be opaque to prevent its use anywhere outside of the `TreasureFactory` module.
In this case, it is not even exposed at all.

Edit the type signatures of `secureChest` and `uniqueTreasures` to add the constraints using extensible records as phantom types.
`secureChest` should take a `Chest` without specific conditions and return a `Maybe Chest`, with the extra condition `securePassword : ()` in its phantom record.
`uniqueTreasures` should take a `List Chest` without specific conditions and return a `List Chest`, with the extra condition `uniqueTreasure : ()` added to the phantom record.

~~~~exercism/note
Elm tests have access to exposed functions, but not to type signatures, it is therefore impossible for tests to verify that you are using the right signatures.
Of course, the strongest indication that you have the right signatures is to succeed in getting the module and tests to compile and run, but we have created an analyzer rule that will check your type signatures once you submit your solution.
~~~~

## 2. Select secure chests

Once you have chests ready, you need to pick out the secure ones.

Implement `secureChest` that only returns a `Just` variant for chests with a password of 8 or more characters.
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
