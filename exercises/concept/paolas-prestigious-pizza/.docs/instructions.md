# Instructions

You are excited to join Paola's Prestigious Pizza as the new restaurant manager.
You have many plans about how to run the place efficiently, and in order to do so, you need some data.
First things first, you need to analyze the menu.

There are many types of pizza on the menu, Paola gave you a list in a text file, with one pizza per line.
Each pizza entry has three components: its name, an optional vegetarian indicator, and a price.

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
    --> Err [{ problem = ExpectingSymbol "€", col = 2, row = 1 }]
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

Alright, what's next?

```
Regina: tomato, ham, mushrooms, cantal - 11€
Formaggio (v): tomato, emmental - 8€
...
```

The ingredients and pizza names seem fairly straightforward: they are all single words made out of upper case and lower case ASCII characters.

Implement `wordParser` to parse the names.
While you are at it, make all the words lowercase for uniformity.

```elm
Parser.run wordParser "REGINA"
    --> Ok "regina"
Parser.run wordParser "tomato"
    --> Ok "tomato"
Parser.run wordParser "(v)"
    --> Ok ""
Parser.run wordParser ""
    --> Ok ""
```

## 4. Parse a list of ingredients

Ingredients, however, come in group:

```
Regina: tomato, ham, mushrooms, cantal - 11€
Formaggio (v): tomato, emmental - 8€
...
```
They are single words separated by commas and possibly spaces.

Implement `ingredientsParser` to parse the ingredients. 

```elm
Parser.run ingredientsParser "tomato, emmental"
    --> Ok ["tomato", "emmental"]
Parser.run ingredientsParser "tomato"
    --> Ok ["tomato"]
```

## 5. Parse full pizza

Now that you have all the ingredients, time to make some `Pizza`!

```
Regina: tomato, ham, mushrooms, cantal - 11€
Formaggio (v): tomato, emmental - 8€
...
```

First you have the pizza name, the optional vegetarian indicator, a colon `':'`, the ingredient list, a dash `'-'` and the price, with possible spaces interspersed.

Implement `pizzaParser` to parse the full pizza.

```elm
Parser.run pizzaParser "Regina: tomato, ham, mushrooms, cantal - 11€"
    --> Ok (Pizza "regina" False ["tomato", "ham", "mushrooms", "cantal"] 11)
```

## 6. Parse full menu

Party time!

Implement `menuParser` to parse a list of all pizzas separated by newline characters `'\n'` in the text file.
Make sure that you got all the pizzas by running the parser until it reaches the end of the file.

```elm
Parser.run menuParser "Regina: tomato, ham, mushrooms, cantal - 11€\nFormaggio (v): tomato, emmental - 8€"
    --> Ok [Pizza "regina" False ["tomato", "ham", "mushrooms", "cantal"] 11,
    --      Pizza "formaggio" True ["tomato", "emmental"] 8]
Parser.run menuParser "Regina: tomato, ham, mushrooms, cantal - 11€\[END]"
    --> Err [{ problem = ExpectingEnd, col = 1, row = 2 }]
```

## 7. Parse multi-word ingredient names

Oh no, it seems you missed something.
Somewhere further down the menu, some ingredients are not single words:

```
...
Tonno: tomato sauce, tuna - 10€
Hawaii: tomato sauce, fresh pineapple, ham - 9€
...
```

Implement `oneIngredientParser` that will accept upper case and lower case ASCII characters or spaces `' '`.
Also take the chance to avoid a small flaw that `wordParser` had by making sure that empty strings are not recognized as valid ingredients and instead emit `Problem "empty string"`.
While you are at it, make sure to make the strings lowercase and also trim whitespace characters on both sides.

```elm
Parser.run oneIngredientParser "Tomato Sauce"
    --> Ok "tomato sauce"
Parser.run oneIngredientParser "   tomato sauce     "
    --> Ok "tomato sauce"
Parser.run oneIngredientParser ""
    --> Err [{ problem = Problem "empty string", col = 1, row = 1 }]
```

Once the parser is defined, use it in `ingredientsParser`.
