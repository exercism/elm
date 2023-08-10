# Instructions

As a magician-to-be, Elyse needs to practice some basics. She has a deck of cards that she wants to manipulate.

To make things a bit easier she only uses the cards 1 to 10.

## 1. Retrieve a card from a deck

Implement the `getCard` function  that returns the card at position `index` from the given deck. If the index is not in the deck, return Nothing.

```elm
getCard 2, ( Array.fromList [ 1, 2, 4, 1 ] )
    --> Just 4
getCard 6, ( Array.fromList [ 1, 2, 4, 1 ] )
    --> Nothing
```

## 2. Change a card in the deck

Implement the `setCard` function that returns a deck with the card at position `index` changed to the new card provided.
If the `index` is not in the deck, return the original deck.

```elm
setCard 2, 6, ( Array.fromList [ 1, 2, 4, 1 ] ) 
    --> Array.fromList [ 1, 2, 6, 1 ]
setCard 6, 6, ( Array.fromList [ 1, 2, 4, 1 ] ) 
    --> Array.fromList [ 1, 2, 4, 1 ]
```

## 3. Add a card to the deck

Implement the `addCard` function that returns a deck with the new card added.

```elm
addCard 8 ( Array.fromList [ 5, 9, 7, 1 ] ) 
    --> Array.fromList [ 5, 9, 7, 1, 8 ]
```

## 4. Remove a card from the deck

Implement the `removeCard` function that returns a deck with the card at position `index` removed.
If the given `index` is not a valid index in the deck, return the original deck.

```elm
removeCard 2 ( Array.fromList [ 3, 2, 6, 4, 8 ] )
    --> Array.fromList [ 3, 2, 4, 8 ]
removeCard 2 ( Array.fromList [ 3, 2 ] )
    --> Array.fromList [ 3, 2 ]
```

## 5. Count the number of even cards in the deck

Implement the `evenCardCount` function that counts the number of even cards in the deck.

```elm
evenCardCount (Array.fromList [ 3, 8, 4, 5, 1, 6, 10 ] )
    --> 4
```
