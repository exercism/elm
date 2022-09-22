# Hints

## General

- General hint 1


## 1. Parse pizza price

You look at the first couple of lines on the menu:

```
Regina: tomato, ham, mushrooms, cantal - 11€
Formaggio (v): tomato, emmental - 8€
...
```

The price seems like a good place to start.
All prices are whole numbers in the Euro currency.

Implement `priceParser` to parse the prices. 
Since all prices are in Euro, you don't need to keep track of the currency, although you still need to parse it.

```elm
Parser.run priceParser "8€"
    --> Ok 8
Parser.run priceParser "8"
    --> Err [{ col = 2, problem = ExpectingSymbol "€", row = 1 }]
```

## 2. Parse vegetarian indicator

You look at the menu again:

```
Regina: tomato, ham, mushrooms, cantal - 11€
Formaggio (v): tomato, emmental - 8€
...
```

The vegetarian indicator `"(v)"` is pretty simple too, you decide to do that next!

Implement `vegetarianParser` to parse the indicator.
The parser should return a `Bool`, `True` if the indicator is there and `False` otherwise. 

```elm
Parser.run vegetarianParser "(v)"
    --> Ok True
Parser.run vegetarianParser ""
    --> Ok False
```

## 3. Parse pizza and ingredient names

## 4. Parse a list of ingredients

## 5. Parse full pizza


## 6. Parse full menu

Careful of spaces eating newlines

## 7. Parse multi-word ingredient names

[resource]: https://some.resource/url
