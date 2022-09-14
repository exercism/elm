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
            test "escaped property" <|
                \() ->
                    SgfParsing.parse "(;A[\\]b\\nc\\nd\\t\\te \\n\\]])"
                        |> Expect.equal (Ok (Node { properties = Dict.singleton "A" [ "]b\nc\nd\t\te \n]" ], children = [] }))
        ]
