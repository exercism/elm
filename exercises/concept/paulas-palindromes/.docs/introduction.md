# Introduction

## Web Applications

Elm is a delightful language for building reliable web applications.
It has friendly error messages, great performance, small assets, and no runtime exceptions.

Probably the most famous and widely copied part of Elm is The Elm Architecture, which is a simple pattern for structuring web applications, and is how all Elm web applications are written.

The core idea is that your code is built around a `Model` of your application state, a way to `update` your model, and a way to `view` your model.

The `Model` contains the application’s state - all the data that the application needs.
If you imagine a simple application with a text box, and text showing the reverse of that text, the model would look like below.
You can also see this example on the [Elm Guide][elm-guide-text-fields].

```elm
type alias Model =
  { text : String
  }
```

`update` is a function that gets called with a `Msg` when there's a change (like the user clicking a button).
It takes the `Msg` and the current `Model`, and returns a new `Model`.

```elm
type Msg
  = TextChanged String

update : Msg -> Model -> Model
update msg model =
  case msg of
    TextChanged newText ->
      { model | text = newText }
```

`view` is a function that returns HTML to show to the user in the browser.
It takes the current `Model` and returns an `Html Msg` (the type that Elm uses to represent HTML).

```elm
view : Model -> Html Msg
view model =
  Html.div []
    [ Html.input
      [ Html.Attributes.placeholder "Text to reverse"
      , Html.Attributes.value model.text
      , Html.Events.onInput TextChanged
      ]
      []
    , Html.div [] [ Html.text (String.reverse model.text) ]
    ]
```

[elm-guide-text-fields]: https://guide.elm-lang.org/architecture/text_fields
