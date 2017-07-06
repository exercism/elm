module Tests exposing (..)

import Test exposing (..)
import Expect
import Triangle exposing (triangleKind, Triangle(..))


tests : Test
tests =
    describe "triangleKind"
        [ test "the solution is for the correct version of the test" <|
            \() -> Expect.equal 2 version
        , test "equilateral triangles have equal sides" <|
            \() -> Expect.equal (Ok Equilateral) (triangleKind 2 2 2)
        , test "larger equilateral triangles also have equal sides" <|
            \() -> Expect.equal (Ok Equilateral) (triangleKind 10 10 10)
        , test "isosceles triangles have last two sides equal" <|
            \() -> Expect.equal (Ok Isosceles) (triangleKind 3 4 4)
        , test "isosceles triangles have first and last sides equal" <|
            \() -> Expect.equal (Ok Isosceles) (triangleKind 4 3 4)
        , test "isosceles triangles have two first sides equal" <|
            \() -> Expect.equal (Ok Isosceles) (triangleKind 4 4 3)
        , test "isosceles triangles have in fact exactly two sides equal" <|
            \() -> Expect.equal (Ok Isosceles) (triangleKind 10 10 2)
        , test "scalene triangles have no equal sides" <|
            \() -> Expect.equal (Ok Scalene) (triangleKind 3 4 5)
        , test "scalene triangles have no equal sides at a larger scale too" <|
            \() -> Expect.equal (Ok Scalene) (triangleKind 10 11 12)
        , test "scalene triangles have no equal sides at a larger scale too 2" <|
            \() -> Expect.equal (Ok Scalene) (triangleKind 5 4 2)
        , test "very small triangles are legal" <|
            \() -> Expect.equal (Ok Scalene) (triangleKind 0.4 0.6 0.3)
        , test "triangles with no size are illegal" <|
            \() -> Expect.equal (Err "Invalid lengths") (triangleKind 0 0 0)
        , test "triangles with negative sides are illegal" <|
            \() -> Expect.equal (Err "Invalid lengths") (triangleKind 3 4 -5)
        , test "triangles violating triangle inequality are illegal 1" <|
            \() -> Expect.equal (Err "Violates inequality") (triangleKind 1 1 3)
        , test "triangles violating triangle inequality are illegal 2" <|
            \() -> Expect.equal (Err "Violates inequality") (triangleKind 7 3 2)
        ]
