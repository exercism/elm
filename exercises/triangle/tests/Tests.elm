module Tests exposing (..)

import Test exposing (..)
import Expect
import Triangle exposing (triangleKind, Triangle(..), version)


tests : Test
tests =
    describe "triangleKind"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , test "equilateral triangles have equal sides" <|
            \() -> Expect.equal (Ok Equilateral) (triangleKind 2 2 2)
        , skip <|
            test "larger equilateral triangles also have equal sides" <|
                \() -> Expect.equal (Ok Equilateral) (triangleKind 10 10 10)
        , skip <|
            test "isosceles triangles have last two sides equal" <|
                \() -> Expect.equal (Ok Isosceles) (triangleKind 3 4 4)
        , skip <|
            test "isosceles triangles have first and last sides equal" <|
                \() -> Expect.equal (Ok Isosceles) (triangleKind 4 3 4)
        , skip <|
            test "isosceles triangles have two first sides equal" <|
                \() -> Expect.equal (Ok Isosceles) (triangleKind 4 4 3)
        , skip <|
            test "isosceles triangles have in fact exactly two sides equal" <|
                \() -> Expect.equal (Ok Isosceles) (triangleKind 10 10 2)
        , skip <|
            test "scalene triangles have no equal sides" <|
                \() -> Expect.equal (Ok Scalene) (triangleKind 3 4 5)
        , skip <|
            test "scalene triangles have no equal sides at a larger scale too" <|
                \() -> Expect.equal (Ok Scalene) (triangleKind 10 11 12)
        , skip <|
            test "scalene triangles have no equal sides at a larger scale too 2" <|
                \() -> Expect.equal (Ok Scalene) (triangleKind 5 4 2)
        , skip <|
            test "very small triangles are legal" <|
                \() -> Expect.equal (Ok Scalene) (triangleKind 0.4 0.6 0.3)
        , skip <|
            test "triangles with no size are illegal" <|
                \() -> Expect.equal (Err "Invalid lengths") (triangleKind 0 0 0)
        , skip <|
            test "triangles with negative sides are illegal" <|
                \() -> Expect.equal (Err "Invalid lengths") (triangleKind 3 4 -5)
        , skip <|
            test "triangles violating triangle inequality are illegal 1" <|
                \() -> Expect.equal (Err "Violates inequality") (triangleKind 1 1 3)
        , skip <|
            test "triangles violating triangle inequality are illegal 2" <|
                \() -> Expect.equal (Err "Violates inequality") (triangleKind 7 3 2)
        ]
