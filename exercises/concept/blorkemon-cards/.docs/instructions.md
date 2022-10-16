# Instructions

You suddenly feel a burst of nostalgia and a strong urge to dust off your old Plokemon™️ cards.
Mokemon™️ cards is a great, old school card trading game.
Each `Card` has a Gokemon™️ `Monster` drawn on it, along with an attack `Power` level, and if you are lucky, the card might even be `Shiny`.

## 1. Compare power levels

Each Shlokemon™️ card looks more powerful than the next, but you better check.

Implement the `isMorePowerful` function. It should return `True` if the card in its first argument is strictly more powerful than the other, and `False` otherwise.

```elm
newthree = ("Newthree", 120, False)
scientuna = ("Scientuna", 6, True)

isMorePowerful newthree scientuna
    --> True
```

## 2. Find the highest power

With a hand full of Mokemon™️ cards, you should be able to prepare the most devastating attack.

Implement the `maxPower` function, which returns the highest power level of two cards.

```elm
maxPower newthree scientuna
    --> 120
```

## 3. Sort the cards

You seem to remember that you had at least one card of each Ryokemon™️, but it's been a while since you last checked, you should sort your cards to compare them to the official listing on Pulpapedia.

Implement the `sortByMonsterName` function, which should take a list of `Cards` and return a list sorted by `Monster` names.

```elm
sortByMonsterName [newthree, scientuna]
    --> [("Newthree", 120, False), ("Scientuna", 6, True)]
```

## 4. Coolest cards first

Tokemon™️ are the coolest thing ever.
You are not using that term lightly, you have a scientific method to demonstrate it.

Implement the `sortByCoolness` function, which sorts a list of cards by placing the coolest ones first.
The coolness of a card is first determined by its shininess: all `Shiny` cards are way cooler than the others.
The second factor is the `Power` level, the higher the better.

```elm
sortByCoolness [newthree, scientuna]
    --> [("Scientuna", 6, True), ("Newthree", 120, False)]
```

## 5. Shiny Power

Shininess is not just for show, in a battle of evenly powered Xokemon™️, a `Shiny` one will always prevail.
This is called the Shiny Power.

Implement the `compareShinyPower` function, which codifies this property.
The `Order` of two cards is determined by the `Power` levels is they are different, but if they are equal, a `Shiny` card will be greater.

```elm
compareShinyPower newthree scientuna
    --> GT
```

## 6. Place your bets

In a game of Yokemon™️ cards, anything goes, but there is still a tendency for more powerful cards to win.

Implement the `expectedWinner` function that returns the name of the `Monster` most expected to win, as determined by the `compareShinyPower` ordering.
The function should return the `Monster` name of the expected winner, or "too close to call" if both opponents have the same Shiny Power.

```elm
expectedWinner newthree scientuna
    --> "Newthree"
```
