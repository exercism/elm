# Introduction

## Introduction

Opaque Types are an encapsulation technique in Elm.
Some people also call this information hiding, or hiding implementation details.
They are also commonly used to enforce validation, using the [Parse, dont validate][parse-dont-validate] pattern.
For example, you could have a `EmailAddress` opaque type, that can only contain valid email addresses (as opposed to a `String`, which can contain anything).

## Creating an Opaque Type

[Custom types][custom-types] have one or more *variants*, and the compiler automatically generates a function to create each *variant*, using the *variant* name.
These are the only way in which custom types can be created.
The compiler also allows destructuring for these variants.

```elm
type Maybe a
    = Nothing --> Variant implies a 'Nothing' function, with type 'Maybe a', and destructuring of 'Nothing'
    | Just a  --> Variant implies a 'Just' function, with type 'a -> Maybe a', and destructuring of 'Just _'
```

By default, all of this is internal to the file / module, and we use the `exposing` keyword to choose what to export.
To create an Opaque Type, you simply choose not to export the *variants*.

When you do this, you almost always need to supply another way to create and get the *variants*, by exposing custom functions.
These custom functions allow you to apply some logic when creating and getting the *variants*.
This hides the internal implementation details of the module, and means that you can change the implementation details as much as you want, as long as the exposed functions remain the same.

## Parse, don't validate

Probably the most common use of Opaque Types is to enforce validation, using the [Parse, dont validate][parse-dont-validate] pattern.
In this pattern, you expose a function that takes an input with less structure / type safety than you want, such as a `String`, and then parse this in to a more structured type, such as `EmailAddress`, either returning the type, or returning an error (usually `Maybe` or `Result`).

For example, in the code below, it is only possible for external modules to create a `EmailAddress` type using the `parseEmailAddress` function, so when you are working with the `EmailAddress` type, you are certain that it is valid.

```elm
module EmailAddress exposing ( EmailAddress, parseEmailAddress, getEmailAddress )

-- The `EmailAddress` custom type has one variant, also called `EmailAddress`
-- When a custom type has one variant, it is idiomatic to use the same name for both.
type EmailAddress = 
  EmailAddress String

-- create an EmailAddress variant
parseEmailAddress: String -> Maybe EmailAddress
parseEmailAddress candidateEmailAddress =   
  if isValidEmailAddress candidateEmailAddress then
    Just (EmailAddress candidateEmailAddress)
  else
    Nothing

-- get an EmailAddress variant
getEmailAddress: EmailAddress -> String
getEmailAddress ( EmailAddress  emailAdress ) =
  emailAdress

isValidEmailAddress: String -> bool
-- ... 
```

[custom-types][https://guide.elm-lang.org/types/custom_types.html]
[parse-dont-validate][https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/] 
[uphold-invariants][https://ckoster22.medium.com/advanced-types-in-elm-opaque-types-ec5ec3b84ed2]
