# About

Elm is a delightful language for building reliable web applications.
It has friendly error messages, great performance, small assets, and no runtime exceptions.

Probably the most famous and widely copied part of Elm is The Elm Architecture, which is a simple pattern for structuring web applications, and is how all Elm web applications are written.

The core idea is that your code is built around a `Model` of your application state, a way to `update` your model, and a way to `view` your model.

The `Model` contains the application’s state - all the data that the application needs.
It can be any type, but in any useful application it is usually a [record][record].
If you imagine a simple application with a text box, and text showing the reverse of that text, the model would look like below.
You can also see this example on the [Elm Guide][elm-guide-text-fields].

```elm
type alias Model =
  { text : String
  }
```

`update` is a function that gets called with a `Msg` when there's a change (like the user clicking a button).
It takes the `Msg` and the current `Model`, and returns a new `Model`.
The `Msg` can be any type, but it is usually a [custom type][custom-type].

```elm
type Msg
  = TextChanged String

update : Msg -> Model -> Model
update msg model =
  case msg of
    TextChanged newText ->
      { model | text = newText }
```

As with all custom types, the variants of the `Msg` can include as much arbitrary information as they need.
In the example above the `TextChanged` variant includes a `String`.

`view` is a function that returns HTML to show to the user in the browser.
It takes the current `Model` and returns an `Html Msg` (the type that Elm uses to represent HTML).
Each HTML element (for example `<div>`) has a corresponding Elm function (`Html.div`), in the `Html` package.
Each of these functions takes two parameters, the first is a list of attributes (from the `Html.Attributes` and `Html.Events` packages), and the second is a list of child elements (functions from the `Html` package).
There is also a `text` function that represents HTML string content, which just takes a string parameter, but is otherwise used in the same way as all the other functions / elements in the `Html` package.

The `view` function can specify that certain events, like clicking a button or editing text in a text box, result in a `Msg` being created, which the Elm Runtime will use to call the `update` function, modify the `Model` and generate updated HTML.
In the code below this happens with `Html.Events.onInput TextChanged`.

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

`Html.Events.onInput` expects to be passed a function (`String -> Msg`) which it will use to create the `Msg`.
Different events expect different functions depending on what information they can provide, so for example `Html.Events.onCheck` (for checkboxes) expects `Bool -> Msg` and `Html.Events.onClick` just expects a `Msg`.

The Elm language is pure and functional and no mutation is possible, so the Elm Runtime handles all the things that change.
You can see all of the different [HTML Elements][html-elements], [Element Attributes][element-attributes] and [HTML Events][html-events] on the Elm package registry.

There are 4 "levels" of web application you can write in Elm, that get progressively more powerful and more complicated (although Elm remains a delightfully simple language and ecosystem).
These are all defined in the [Browser package][browser-package]:

- [sandbox][browser-sandbox] — react to user input, like buttons and checkboxes
- [element][browser-element] — talk to the outside world, using HTTP and JavaScript interop
- [document][browser-document] — control the `<title>` and `<body>` of a web page
- [application][browser-application] — create full single-page appliations that handle routing / url changes

This concept uses the [sandbox][browser-sandbox], as it is the simplest (and because it is a sandbox, it is relatively easy to work with the Exercism online editor).
The entry module for an Elm program must be called `Main`, and the function that creates the application must be called `main`,  as below.

```elm
import Browser
import Html exposing (Html, Attribute, div, input, text)
import Html.Attributes exposing (placeholder, value)
import Html.Events exposing (onInput)

main =
  Browser.sandbox { init = init, update = update, view = view }

init : Model
init =
  { text = "" }

-- Add Model, Msg, update and view here
```

We have already seen the `update` and `view` functions, and the [sandbox][browser-sandbox] additionally requires an `init` function, to return the initial state of the `Model`.

[record]: https://elm-lang.org/docs/records
[custom-type]: https://guide.elm-lang.org/types/custom_types.html
[elm-guide-text-fields]: https://guide.elm-lang.org/architecture/text_fields
[html-elements]: https://package.elm-lang.org/packages/elm/html/latest/Html
[element-attributes]: https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes
[html-events]: https://package.elm-lang.org/packages/elm/html/latest/Html-Events
[browser-package]: https://package.elm-lang.org/packages/elm/browser/latest/
[browser-sandbox]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#sandbox
[browser-element]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#element
[browser-document]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#document
[browser-application]: https://package.elm-lang.org/packages/elm/browser/latest/Browser#application
