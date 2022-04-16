# Instructions

In this exercise you're going to write some code to help Betty's Bike Shop, an online shop for bikes and parts.
You have three tasks, aiming at correctly displaying the bikes and parts prices on the website.

## 1. Export the `penceToPounds` function

Your colleague has already written the skeleton of the module, the undefined functions `penceToPounds` and `poundsToString`.
However, they have forgotten to export the `penceToPounds` function, so it is currently not visible by other modules or by the test suite.

Add `penceToPounds` to the list of exported functions.

## 2. Convert pence to pounds

Currently, the price is stored as an integer number of *pence* (the bike shop is based in the UK).
On the website, we want to show the price in *pounds*, where 1.00 pound amounts to 100 pence.
Your first task is to implement the `penceToPounds` function, taking an `Int` amount of pence, and converting it into its equivalent pounds as a `Float`.
You should also define the type annotation for that function.

```elm
penceToPounds 106
    --> 1.06
```

## 3. Format the price for display on the website

Since Betty's bikes are sold in pounds, prices should be displayed with the symbol "£".
Your second task is thus to implement the `poundsToString` function, taking an amount of pounds as a `Float` and returning its price displayed as a `String` with the pound symbol prepended.
You should import the `String` module before using it.
You should also define the type annotation for `poundsToString`.

```elm
poundsToString 1.06
    --> "£1.06"
```
