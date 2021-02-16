# Instructions

In this exercise you're going to write some code to help Betty's Bike Shop, an online shop for bikes and parts.

## Format the price for display on the website

Currently, the price is stored as an integer number of *pence* (The bike shop is based in the UK).

On the website, we want to show the price in *pounds*, with the *pence* coming after the decimal point.

There are 100 pence in a pound, so a price of 599 pence should be converted in to the string "£5.99".

Please define the `formatPrice` function to do this.

The function should have a Type Annotation, to define the types of the parameters that it takes, and the type of the value that it returns. This is not tested, as it is hard to do in Elm. In production code, you would probably integrate [Elm Review](https://package.elm-lang.org/packages/jfmengels/elm-review/latest/), and apply the [NoMissingTypeAnnotation](https://package.elm-lang.org/packages/jfmengels/elm-review-common/latest/NoMissingTypeAnnotation) rule.

```elm
-- add type annotation
formatPrice priceInPence
-- "£5.99" or similar
```

