# Introduction

The `Result` type is the solution in the Elm language for error reporting and an enabler for error recovery. It is somewhat similar to the `Maybe` type, but where Maybe can be returned by functions that may fail, it doesn't tell you anything about why it failed. Result includes this context about why something failed.

## Definition and type variable

The `Result` type is defined as follows:

```elm
type Result error value
  = Ok value
  | Err error
```

This is known as a "custom type" definition in Elm terminology.
Custom types are introduced in details in another concept of this track but we won't need it to understand specifically `Result`.
The `error` and `value` in `OK value` and `Error error` represent a type variable, meaning it can be any type, such as `Int`, `Bool` or `String`.
As such, a `Result String Int` is a variable that is expected to contain an `Int`, and if there is an error this will be represented as a `String`.

```elm
ageFromString : String -> Result String Int
ageFromString input =
  case String.toInt input of
    Nothing ->
      Err "That is not a number!"

    Just age ->
      if age < 0 then
        Err "Please try again after you are born."

      else if age > 135 then
        Err "Are you some kind of turtle?"

      else
        Ok age
```

The vertical bar `|` in the type definition of `Result` means "OR".
It indicates that it can either be `Ok` something OR be `Error` something.

## Reading the content of a Result value

Reading the content of a `Result` value is done via "pattern matching".
Pattern matching is also introduced in more details in another concept, so we just focus on how pattern matching a `Result` works.

```elm
formatAge : Int -> String
formatAge age =
    "You are " ++ toString(age)

howOldAmI : String -> String
howOldAmI age =
    case ageFromString age of
        Err message -> message
        Ok age -> formatAge age

howOldAmI "Bananas"
    --> "That is not a number!"

howOldAmI "32"
    --> "You are 32"
```

Everytime you use a `Result` value, the Elm compiler will check that your code handles all possibilities so you can never pattern match a `Result` and only handle the case where there is a `Ok value`.
This may seem annoying at first, but it is one of the greatest strengths of the Elm language.
This will prevent hundreds of bugs and makes compiler-guided refactoring a fearless and rewarding experience.

## Manipulating the content of a Result value

There are various functions to work with Result types, which are usually preferable to pattern matching. `map` can be used to map the value, and `andThen` can be used to chain together functions that may fail.

Result.map is used to change the Ok value and is useful to chain functions together without having to worry about whether the Result contains an error or not. If the value is Ok, Result.map calls the chained function (`formatAge` below), but if there is an error, Result.map does nothing, and just returns the error.

```elm
howOldAmI : String -> Result String String
howOldAmI age =
    Result.map formatAge (ageFromString age)

howOldAmI "Bananas"
    --> Err "That is not a number!" (ageFromString returns Err, so Result.map just returns the Err)

howOldAmI "32"
    --> Ok "You are 32" (ageFromString returns Ok 32, Result.map passses this to formatAge)
```

Result.andThen is used to change the Ok value and is useful to chain functions together without having to worry about whether the Result contains an error or not. It is similar to Result.map, but Result.andThen work with a chained function (`formatSpecialBirthday` below) that also returns a Result. `Result.map` can do this as well, but it ends up with an extra layer of nesting, which `andThen` cleverly avoids.

```elm
formatSpecialBirthday : Int -> Result String String
formatSpecialBirthday age =
    if age == 18 then
        Ok "Welcome to adulthood!"

    else if age == 65 then
        Ok "Welcome to retirement!"

    else
        Err "Not a special birthday"

specialBirthdayMessage : String -> Result String String
specialBirthdayMessage age =
    Result.andThen formatSpecialBirthday (ageFromString age)

specialBirthdayMessage "Bananas"
    --> Err "That is not a number!" (ageFromString returns Err, so Result.andThen just returns the Err)

specialBirthdayMessage "32"
    --> Err "Not a special birthday" (ageFromString returns Ok 32, Result.map passses this to formatSpecialBirthday, which returns Err)

specialBirthdayMessage "18"
    --> Ok "Welcome to adulthood" (ageFromString returns Ok 32, Result.map passses this to formatSpecialBirthday, which returns Ok)
    --> If we used Result.map, it would be OK (Ok "Welcome to audulthood"), which is annoying
```
