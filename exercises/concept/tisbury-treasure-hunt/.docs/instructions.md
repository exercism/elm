# Instructions

Aazra and Rui are designing a pirate-themed treasure hunt. There is a list of treasures with map locations, the other a list of place names with map locations.

| Treasure                    | Location |
| --------------------------- | -------- |
| Amethyst Octopus            | (1, F)   |
| Angry Monkey Figurine       | (5, B)   |
| Antique Glass Fishnet Float | (3, D)   |
| Brass Spyglass              | (4, B)   |
| Carved Wooden Elephant      | (8, C)   |
| Crystal Crab                | (6, A)   |
| Glass Starfish              | (6, D)   |
| Model Ship in Large Bottle  | (8, A)   |
| Pirate Flag                 | (7, F)   |
| Robot Parrot                | (1, C)   |
| Scrimshaw Whale's Tooth     | (1, F)   |
| Silver Seahorse             | (4, E)   |
| Vintage Pirate Hat          | (7, E)   |

| Place Name                            | Location | Quadrant |
| ------------------------------------- | -------- | -------- |
| Seaside Cottages                      | (C, 1) | Blue      |
| Aqua Lagoon (Island of Mystery)       | (F, 1) | Yellow    |
| Deserted Docks                        | (A, 2) | Blue      |
| Spiky Rocks                           | (D, 3) | Yellow    |
| Abandoned Lighthouse                  | (B, 4) | Blue      |
| Hidden Spring (Island of Mystery)     | (E, 4) | Yellow    |
| Stormy Breakwater                     | (B, 5) | Purple    |
| Old Schooner                          | (A, 6) | Purple    |
| Tangled Seaweed Patch                 | (D, 6) | Orange    |
| Quiet Inlet (Island of Mystery)       | (E, 7) | Orange    |
| Windswept Hilltop (Island of Mystery) | (F, 7) | Orange    |
| Harbor Managers Office                | (A, 8) | Purple    |
| Foggy Seacave                         | (C, 8) | Purple    |

Players will travel around the map picking up treasures as they go.
Treasure and place locations are formatted differently, to add an extra challenge.
There are also some special places, where certain treasures can be swapped for certain other ones, to add an extra twist to the game.
Your job is to write functions to help them with their game.

## 1. Convert locations

Implement the `placeLocationToTreasureLocation` function that takes a Place Location (such as `('C', 1)`) and converts it to a Treasure Location (such as `(1, 'C')`).

```elm
placeLocationToTreasureLocation ('C', 1)
--> (1,'C')
```

## 2. Compare Treasure and Place locations

Implement the `treasureLocationMatchesPlaceLocation` function that takes a `PlaceLocation` (such as `('C', 1)`) and returns true if it matches a `TreasureLocation` (such as `(1, 'C')`).

```elm
treasureLocationMatchesPlaceLocation ('C', 1) (1, 'C')
--> true

treasureLocationMatchesPlaceLocation ('C', 1) (2, 'C')
--> false
```

## 3. Count Treasure Locations

Implement the `countPlaceTreasures` function, that takes a Place (such as `("Aqua Lagoon (Island of Mystery)", ('F', 1))`), and the list of Treasures, and returns the number of treasures that can be found there.

```elm
place = ("Aqua Lagoon (Island of Mystery)", ('F', 1))

countPlaceTreasures place treasures =
--> 2
```

## 4. Special Places

Implement the `specialCaseSwapPossible` function, which takes a Treasure (such as `("Amethyst Octopus", (1, 'F'))`) and a Place (such as `("Seaside Cottages ", ('C', 1))`), and returns true for the following combinations:

- The Brass Spyglass can be swapped for any other treasure at the Abandoned Lighthouse
- The Amethyst Octopus can be swapped for the Crystal Crab or the Glass Starfish at the Stormy Breakwater
- The Vintage Pirate Hat can be swapped for the Model Ship in Large Bottle or the Antique Glass Fishnet Float at the Harbor Managers Office

Try to implement this function as a case statement with an ad hoc tuple, instead of using if statements (this is a common idiom in Elm).
