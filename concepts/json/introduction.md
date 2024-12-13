# Introduction

## JSON

JSON (JavaScript Object Notation) is a human readable data and file format commonly used to exchange data, in particular for web applications.
As such, it is no surprise that is holds a special place in the Elm language.

Elm provides the core modules `Json.Decode` and `Json.Encode` to parse and write JSON data.
JSON Decoders are a way to _declare_ what type of data is expected and which data structure the data should map to.

Let's import some aliases and types from the modules:

```elm
import Json.Decode as Decode exposing (Decoder, Error)
import Json.Encode as Encode exposing (Value)
```

Using `Decode.decodeString : Decoder a -> String -> Result Error a` with a decoder and a JSON string will either succeed if the string confirms to the decoder specifications, or fail otherwise.
There is no way of inspecting the raw JSON data when defining the decoder, which could feel unusual coming from imperative languages.

## Basic data type decoders

JSON has a small number of core data types:

- String: encoded with double quotes `"hello world"`
- Boolean: either `true` or `false`
- Number: such as `34` or `0.12`
- Null: the absence of data `null`

Each of these is associated with a `Decode` function:

```elm
Decode.decodeString Decode.string """\"hello\""""
    --> Ok "hello"

Decode.decodeString Decode.string """null"""
    --> Err ...

Decode.decodeString Decode.bool """true"""
    --> Ok True

Decode.decodeString Decode.bool """0"""
    --> Err ...

Decode.decodeString Decode.int """12"""
    --> Ok 12

Decode.decodeString Decode.float """3.14"""
    --> Ok 3.14

Decode.decodeString (Decode.null AnyValue) """null"""
    --> Ok AnyValue

Decode.decodeString (Decode.null AnyValue) """true"""
    --> Err ...
```

Note that `Decode.null` lets you decide how to model a `null` in your program by requiring an arbitrary value as argument (maybe `()`, `Nothing`, or anything appropriate to your program).

## Combining decoders

JSON also defines two data structures to collect core data types:

- Array: a collection of other data types `[0, null, "none", []]`
- Object: a collection of key-value pairs `{"id": 1, "is_admin": false, "more_info": {}}`

`Decode` also offers functions to decode these:

```elm
Decode.decodeString (Decode.list Decode.int) """[1, 2, 3]"""
    --> Ok [1, 2, 3]

Decode.decodeString (Decode.list Decode.int) """[1, 2, 3, "not an int"]"""
    --> Err ...

Decode.decodeString (Decode.dict Decode.int) """{ "key1": 17, "key2": 71 }"""
    --> Ok (Dict.fromList [("key1", 17), ("key2", 71)])

Decode.decodeString (Decode.dict Decode.int) """{ "key1": 17, "key2": "seventy-one" }"""
    --> Err ...
```

These functions `Decode.list : Decoder a -> Decoder (List a)` and `Decode.dict : Decoder a -> Decoder (Dict String a)` each expect a decoder as argument, which is expected to decode every single element elements of the data structure.
If the argument decoder fails to decode any element of an array or object value, the whole decoder fails, which is a common pattern.

Combining simple decoders into more complex ones is the core idea of the technique.
We will introduce several more functions that can be used to build arbitrarily complex real-world data decoders through means of an example.

## GeoJSON

For practicing combining basic decoders to parse complex JSON data, let's build decoders for parsing (a subset of) GeoJSON data.
GeoJSON is a specialized JSON-based data format used to represent geographic features, such as locations, paths or regions, specified with 2D or 3D geographic coordinates, along with other properties.

### Geometry Object

A GeoJSON Geometry Object is an object that contains a `type` field with a string value (there are 7 possible type values) and a `coordinates` field with geographic coordinates (collected in a structure that depends on the type).
For example,

```json
{
  "type": "Point",
  "coordinates": [127.831, 26.461]
}
```

or

```json
{
  "type": "LineString",
  "coordinates": [
    [127.831, 26.461],
    [127.829, 26.465],
    [127.829, 26.469],
    [127.83, 26.47]
  ]
}
```

A Geometry Object could be represented in Elm with the following type

```elm
type Geometry
  = Point (List Float)
  | LineString (List (List Float))
  | ...
```

To probe the value of a certain field, we can use `Decode.field : String -> Decoder a -> Decoder a` which decodes the value of a specific key of an object.

```elm
decodePointCoordinates : Decoder (List Float)
decodePointCoordinates =
    Decode.field "coordinates" (Decode.list Decode.float)

decodeLineStringCoordinates : Decoder (List (List Float))
decodeLineStringCoordinates =
    Decode.field "coordinates" (Decode.list (Decode.list Decode.float))
```

To transform the value successfully parsed by a decoder, we can use `Decode.map : (a -> value) -> Decoder a -> Decoder value`, or any of its siblings, from `Decode.map2  (a -> b -> value) -> Decoder a -> Decoder b -> Decoder value` to `Decode.map8`.

In this case, we want to decide which coordinate decoder to use depending on the value in the `type` field, which is a perfect job for `Decode.andThen : (a -> Decoder b) -> Decoder a -> Decoder b` and its friends `Decode.succeed : a -> Decoder a` and `Decode.fail : String -> Decoder a`.

```elm
decodeGeometry : Decoder Geometry
decodeGeometry =
    Decode.field "type" Decode.string
        |> Decode.andThen
            (\value ->
                case value of
                    "Point" ->
                        decodePointCoordinates |> Decode.map Point

                    "LineString" ->
                        decodeLineStringCoordinates |> Decode.map LineString

                    _ ->
                        Decode.fail "Geometry not implemented yet, or invalid type value"
            )
```

Note at this point that we could use `Decode.andThen` to validate the coordinates (checking that the coordinates come in pairs or triplets and checking that the coordinate values make geographic sense).

```elm
Decode.decodeString decodeGeometry """{"type": "Point", "coordinates": [127.831, 26.461]}"""
    --> Ok (Point [127.831, 26.461])

Decode.decodeString decodeGeometry """{"type": "LineString", "coordinates": [127.831, 26.461]}"""
    --> Err ...
```

### Feature Object

A GeoJSON Feature Object represents something spatially bounded: it has a `type` field with the `"Feature"` value, a `geometry` field with a Geometry Object or a `null`, a `properties` field with an arbitrary JSON Object or a `null`, and an optional `id` field with a JSON string or number value.

```json
{
  "type": "Feature",
  "geometry": null,
  "properties": null
}
```

or

```json
{
  "type": "Feature",
  "id": "0157",
  "geometry": {
    "type": "Point",
    "coordinates": [127.831, 26.461]
  },
  "properties": {
    "country": "Japan"
  }
}
```

Let's tackle the `id` field first.
If it exists, it must accommodate strings or numbers, so we could either introduce a custom type for the value, or always save is as a string.

To choose between two possible decoders, we can use `Decode.oneOf : List (Decoder a) -> Decoder a`.

```elm
decodeFeatureId : Decoder String
decodeFeatureId =
    Decode.oneOf
        [ Decode.string
        , Decode.int |> Decode.map String.fromInt
        , Decode.float |> Decode.map String.fromFloat
        ]
        |> Decode.field "id"

Decode.decodeString decodeFeatureId """{"id": "seventeen"}"""
    --> Ok "seventeen"

Decode.decodeString decodeFeatureId """{"id": 17}"""
    --> Ok "17"

Decode.decodeString decodeFeatureId """{"type": "Point"}"""
    --> Er ...
```

To express that the field is optional, we could use the same technique

```elm
decodeMaybeFeatureId : Decoder (Maybe String)
decodeMaybeFeatureId =
    Decode.oneOf
        [ decodeFeatureId |> Decode.map Just
        , Decode.succeed Nothing
        ]
```

But we could instead use `Decode.maybe : Decoder a -> Decoder (Maybe a)`

```elm
decodeMaybeFeatureId : Decoder (Maybe String)
decodeMaybeFeatureId =
    Decode.maybe decodeFeatureId

Decode.decodeString decodeMaybeFeatureId """{"id": 17}"""
    --> Ok (Just "17")

Decode.decodeString decodeMaybeFeatureId """{"type": "Point"}"""
    --> Ok Nothing
```

Note that `decodeMaybeFeatureId` (or any decoder wrapped with `Decode.maybe`) will always succeed since it can always fallback on `Ok Nothing`, although a decoder that uses it might still fail

```elm
Decode.decodeString (Decode.list decodeMaybeFeatureId) """{"id": 17}"""
    --> Err ...
```

Next, let's focus on the `geometry` field, which can either be a Geometry Object or be `null`.
We could use `Decode.oneOf` once again, but there is a better option: `Decode.nullable : Decoder a -> Decoder (Maybe a)`.

```elm
decodeFeatureGeometry : Decoder (Maybe Geometry)
decodeFeatureGeometry =
    Decode.nullable decodeGeometry
        |> Decode.field "geometry"

Decode.decodeString decodeFeatureGeometry """{"geometry": {"type": "Point", "coordinates": [127.831, 26.461]}}"""
    --> Ok (Just (Point [127.831, 26.461]))

Decode.decodeString decodeFeatureGeometry """{"geometry": null}"""
    --> Ok Nothing

Decode.decodeString decodeFeatureGeometry """{"geometry": {}}"""
    --> Err ...
```

`Decode.maybe` and `Decode.nullable` have the same signature, but their behavior is different, since the `OK Nothing` result of a `Decode.nullable` will only come from the specific JSON value `null`.

Finally, the `properties` field can contain an arbitrary JSON Object or a `null`, which is a job for `Decode.value : Decoder Value`.

```elm
decodeProperties : Decoder (Maybe (Dict String Value))
decodeProperties =
    Decode.nullable (Decode.dict Decode.value)
        |> Decode.field "properties"


Decode.decodeString decodeProperties """{"properties": null}"""
    --> Ok Nothing

Decode.decodeString decodeProperties """{"properties": {"country": "Japan"}}"""
    --> Ok (Just (Dict.fromList [("country", <internals>)]))

Decode.decodeString decodeProperties """{"properties": 17}"""
    --> Err ...
```

Note that `Value` is an opaque type, which means you cannot easily probe its content.
To use it, you can either write a decoder for it and run it with `Decode.decodeValue : Decoder a -> Value -> Result Error a`, or send it to JavaScript directly via a port.

We are ready to parse Feature Objects:

```elm
type alias Feature =
    { id : Maybe String
    , geometry : Maybe Geometry
    , properties : Maybe (Dict String Value)
    }

decodeFeature : Decoder Feature
decodeFeature =
    Decode.field "type" Decode.string
        |> Decode.andThen
            (\value ->
                if value /= "Feature" then
                    Decode.fail "not a Feature"

                else
                    Decode.map3 Feature
                        decodeMaybeFeatureId
                        decodeFeatureGeometry
                        decodeProperties
            )

Decode.decodeString decodeFeature """{"type": "Feature", "geometry": null, "properties": null}"""
    --> Ok { geometry = Nothing, id = Nothing, properties = Nothing }

"""
{
  "type": "Feature",
  "id": "0157",
  "geometry": {
    "type": "Point",
    "coordinates": [127.831, 26.461]
  },
  "properties": {
    "country": "Japan"
  }
}
"""
  |> Decode.decodeString decodeFeature
    --> Ok { geometry = Just (Point [127.831,26.461]), id = Just "0157", properties = Just (Dict.fromList [("country",<internals>)]) }
```

## JSON Encoders

Encoders allow to write valid JSON from Elm values using the `Encode.encode : Int -> Value -> String` function.
The first argument specifies the amount of indentation in the final result, and the second argument is the JSON value to write.

A `Value` can either be obtained from `Decode.value` or be produced from one of the encoders:

```elm
Encode.encode 0 (Encode.string "hello")
    --> "hello"

Encode.encode 0 (Encode.bool True)
    --> "true"

Encode.encode 0 (Encode.int 12)
    --> "12"

Encode.encode 0 (Encode.float 3.14)
    --> "3.14"

Encode.encode 0 Encode.null
    --> "null"

Encode.encode 0 (Encode.list Encode.int [1, 2, 3])
    --> "[1,2,3]"

Encode.encode 4 (Encode.list Encode.int [1, 2, 3])
    --> "[\n    1,\n    2,\n    3\n]"

Encode.encode 0 (Encode.dict String.toLower Encode.int (Dict.fromList [("KEY1", 17), ("KEY2", 71)]))
    --> "{\"key1\":17,\"key2\":71}"

Encode.encode 4 (Encode.dict String.toLower Encode.int (Dict.fromList [("KEY1", 17), ("KEY2", 71)]))
    --> "{\n    \"key1\": 17,\n    \"key2\": 71\n}"
```

as well as with `Encode.object : List ( String, Value ) -> Value`

```elm
Encode.object
    [ ( "key1", Encode.int 17 )
    , ( "key2", Encode.int 71 )
    ]
    |> Encode.encode 0
    --> "{\"key1\":17,\"key2\":71}"
```

Le's define encoders for the GeoJSON decoders defined earlier

```elm
encodeGeometry : Geometry -> Value
encodeGeometry geometry =
    case geometry of
        Point coord ->
            Encode.object
                [ ( "type", Encode.string "Point" )
                , ( "coordinates", Encode.list Encode.float coord )
                ]

        LineString coord ->
            Encode.object
                [ ( "type", Encode.string "LineString" )
                , ( "coordinates", Encode.list (Encode.list Encode.float) coord )
                ]

encodeFeature : Feature -> Value
encodeFeature feature =
    let
        maybeId =
            case feature.id of
                Nothing ->
                    []

                Just id ->
                    [ ( "id", Encode.string id ) ]
    in
    Encode.object
        (maybeId
            ++ [ ( "type", Encode.string "Feature" )
               , ( "geometry"
                 , case feature.geometry of
                    Nothing ->
                        Encode.null

                    Just geometry ->
                        encodeGeometry geometry
                 )
               , ( "properties"
                 , case feature.properties of
                    Nothing ->
                        Encode.null

                    Just dict ->
                        Encode.dict identity identity dict
                 )
               ]
        )
```

In general, a good test for your decoder-encoder pairs is checking that `elmValue |> encoder |> decoder == elmValue`.
