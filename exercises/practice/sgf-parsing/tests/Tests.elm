module Tests exposing (tests)

import Dict
import Expect
import SgfParsing exposing (Tree(..))
import Test exposing (Test, describe, skip, test)


tests : Test
tests =
    describe "SgfParsing"
        [ -- skip <|
          test "empty input" <|
            \() ->
                SgfParsing.parse ""
                    |> Expect.equal (Err "tree missing")
        , skip <|
            test "tree with no nodes" <|
                \() ->
                    SgfParsing.parse "()"
                        |> Expect.equal (Err "tree with no nodes")
        , skip <|
            test "node without tree" <|
                \() ->
                    SgfParsing.parse ";"
                        |> Expect.equal (Err "tree missing")
        , skip <|
            test "node without properties" <|
                \() ->
                    SgfParsing.parse "(;)"
                        |> Expect.equal (Ok (Node { properties = Dict.empty, children = [] }))
        , skip <|
            test "single node tree" <|
                \() ->
                    SgfParsing.parse "(;A[B])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "B" ], children = [] }))
        , skip <|
            test "multiple properties" <|
                \() ->
                    SgfParsing.parse "(;A[b]C[d])"
                        |> Expect.equal
                            (Ok
                                (Node
                                    { properties = Dict.fromList [ ( "A", [ "b" ] ), ( "C", [ "d" ] ) ]
                                    , children = []
                                    }
                                )
                            )
        , skip <|
            test "properties without delimiter" <|
                \() ->
                    SgfParsing.parse "(;A)"
                        |> Expect.equal (Err "properties without delimiter")
        , skip <|
            test "all lowercase property" <|
                \() ->
                    SgfParsing.parse "(;a[b])"
                        |> Expect.equal (Err "property must be in uppercase")
        , skip <|
            test "upper and lowercase property" <|
                \() ->
                    SgfParsing.parse "(;Aa[b])"
                        |> Expect.equal (Err "property must be in uppercase")
        , skip <|
            test "two nodes" <|
                \() ->
                    SgfParsing.parse "(;A[B];B[C])"
                        |> Expect.equal
                            (Ok
                                (Node
                                    { properties = Dict.singleton "A" [ "B" ]
                                    , children = [ Node { properties = Dict.singleton "B" [ "C" ], children = [] } ]
                                    }
                                )
                            )
        , skip <|
            test "two child trees" <|
                \() ->
                    SgfParsing.parse "(;A[B](;B[C])(;C[D]))"
                        |> Expect.equal
                            (Ok
                                (Node
                                    { properties = Dict.singleton "A" [ "B" ]
                                    , children =
                                        [ Node { properties = Dict.singleton "B" [ "C" ], children = [] }
                                        , Node { properties = Dict.singleton "C" [ "D" ], children = [] }
                                        ]
                                    }
                                )
                            )
        , skip <|
            test "multiple property values" <|
                \() ->
                    SgfParsing.parse "(;A[b][c][d])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "b", "c", "d" ], children = [] }))
        , skip <|
            test "within property values, whitespace characters such as tab are converted to spaces" <|
                \() ->
                    SgfParsing.parse "(;A[hello\t\tworld])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "hello  world" ], children = [] }))
        , skip <|
            test "within property values, newlines remain as newlines" <|
                \() ->
                    SgfParsing.parse "(;A[hello\n\nworld])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "hello\n\nworld" ], children = [] }))
        , skip <|
            test "escaped closing bracket within property value becomes just a closing bracket" <|
                \() ->
                    SgfParsing.parse "(;A[\\]])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "]" ], children = [] }))
        , skip <|
            test "escaped backslash in property value becomes just a backslash" <|
                \() ->
                    SgfParsing.parse "(;A[\\\\])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "\\" ], children = [] }))
        , skip <|
            test "opening bracket within property value doesn't need to be escaped" <|
                \() ->
                    SgfParsing.parse "(;A[x[y\\]z][foo]B[bar];C[baz])"
                        |> Expect.equal
                            (Ok
                                (Node
                                    { properties = Dict.fromList [ ( "A", [ "x[y]z", "foo" ] ), ( "B", [ "bar" ] ) ]
                                    , children = [ Node { properties = Dict.singleton "C" [ "baz" ], children = [] } ]
                                    }
                                )
                            )
        , skip <|
            test "semicolon in property value doesn't need to be escaped" <|
                \() ->
                    SgfParsing.parse "(;A[a;b][foo]B[bar];C[baz])"
                        |> Expect.equal
                            (Ok
                                (Node
                                    { properties = Dict.fromList [ ( "A", [ "a;b", "foo" ] ), ( "B", [ "bar" ] ) ]
                                    , children = [ Node { properties = Dict.singleton "C" [ "baz" ], children = [] } ]
                                    }
                                )
                            )
        , skip <|
            test "parentheses in property value don't need to be escaped" <|
                \() ->
                    SgfParsing.parse "(;A[x(y)z][foo]B[bar];C[baz])"
                        |> Expect.equal
                            (Ok
                                (Node
                                    { properties = Dict.fromList [ ( "A", [ "x(y)z", "foo" ] ), ( "B", [ "bar" ] ) ]
                                    , children = [ Node { properties = Dict.singleton "C" [ "baz" ], children = [] } ]
                                    }
                                )
                            )
        , skip <|
            test "escaped tab in property value is converted to space" <|
                \() ->
                    SgfParsing.parse "(;A[hello\\\tworld])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "hello world" ], children = [] }))
        , skip <|
            test "escaped newline in property value is converted to nothing at all" <|
                \() ->
                    SgfParsing.parse "(;A[hello\\\nworld])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "helloworld" ], children = [] }))
        , skip <|
            test "escaped t and n in property value are just letters, not whitespace" <|
                \() ->
                    SgfParsing.parse "(;A[\\t = t and \\n = n])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "t = t and n = n" ], children = [] }))
        , skip <|
            test "mixing various kinds of whitespace and escaped characters in property value" <|
                \() ->
                    SgfParsing.parse "(;A[\\]b\nc\\\nd\t\te\\\\ \\\n\\]])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "]b\ncd  e\\ ]" ], children = [] }))
        ]
