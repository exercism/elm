# Hints

## General

- Read the documentation for [sets][set]
- The documentation for [lists][lists] might be useful too

## 1. Start a collection

- The most appropriate `Set` function is [`Set.singleton`][singleton]

## 2. Grow the collection

- Use the [`Set.insert` function][insert]
- Use the [`Set.member` function][member]

## 3. Start trading

- Use the [`Set.member` function][member]
- Use the [`Set.insert` function][insert]
- Use the [`Set.remove` function][remove]

## 4. There can be only one of each

- A `Set` has the property of only holding unique values
- Use the [`Set.fromList` function][fromList]
- Use the [`Set.toList` function][toList]
- `Set.toList` is guaranteed to return a sorted list

## 5. Cards they don't have

- Use the [`Set.diff` function][diff]
- Use the [`Set.size` function][size]

## 6. Cards they all have

- Use the [`List.foldl` or `List.foldr` functions][fold]
- Use pattern matching on the list to differentiate empty and non-empty lists
- Use the [`Set.intersect` function][intersect]
- Use the [`Set.toList` function][toList]
- `Set.toList` is guaranteed to return a sorted list

## 7. All of the cards

- Use the [`List.foldl` or `List.foldr` functions][fold]
- Use [`Set.empty`][empty] as accumulator
- Use the [`Set.union` function][union]
- Use the [`Set.size` function][size]

## 8. Shiny for the win

- Use the [`Set.partition` function][partition]
- Use the [`String.startsWith` function][startsWith]
- Use the [`Set.toList` function][toList]
- `Set.toList` is guaranteed to return a sorted list


[set]: https://package.elm-lang.org/packages/elm/core/latest/Set
[lists]: https://package.elm-lang.org/packages/elm/core/latest/List
[singleton]: https://package.elm-lang.org/packages/elm/core/latest/Set#singleton
[member]: https://package.elm-lang.org/packages/elm/core/latest/Set#member
[insert]: https://package.elm-lang.org/packages/elm/core/latest/Set#insert
[remove]: https://package.elm-lang.org/packages/elm/core/latest/Set#remove
[fromList]: https://package.elm-lang.org/packages/elm/core/latest/Set#fromList
[toList]: https://package.elm-lang.org/packages/elm/core/latest/Set#toList
[diff]: https://package.elm-lang.org/packages/elm/core/latest/Set#diff
[size]: https://package.elm-lang.org/packages/elm/core/latest/Set#size
[fold]: https://package.elm-lang.org/packages/elm/core/latest/List#foldl
[intersect]: https://package.elm-lang.org/packages/elm/core/latest/Set#intersect
[empty]: https://package.elm-lang.org/packages/elm/core/latest/Set#empty
[union]: https://package.elm-lang.org/packages/elm/core/latest/Set#union
[partition]: https://package.elm-lang.org/packages/elm/core/latest/Set#partition
[startsWith]: https://package.elm-lang.org/packages/elm/core/latest/String#startsWith
