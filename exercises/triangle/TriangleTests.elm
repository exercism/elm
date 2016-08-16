module Main exposing (..)

import ElmTest exposing (..)
import Triangle exposing (..)


tests : Test
tests =
    suite "triangleKind"
        [ test "the solution is for the correct version of the test"
            (assertEqual 2 version)
        , test "equilateral triangles have equal sides"
            (assertEqual (Ok Equilateral) (triangleKind 2 2 2))
        , test "larger equilateral triangles also have equal sides"
            (assertEqual (Ok Equilateral) (triangleKind 10 10 10))
        , test "isosceles triangles have last two sides equal"
            (assertEqual (Ok Isosceles) (triangleKind 3 4 4))
        , test "isosceles triangles have first and last sides equal"
            (assertEqual (Ok Isosceles) (triangleKind 4 3 4))
        , test "isosceles triangles have two first sides equal"
            (assertEqual (Ok Isosceles) (triangleKind 4 4 3))
        , test "isosceles triangles have in fact exactly two sides equal"
            (assertEqual (Ok Isosceles) (triangleKind 10 10 2))
        , test "scalene triangles have no equal sides"
            (assertEqual (Ok Scalene) (triangleKind 3 4 5))
        , test "scalene triangles have no equal sides at a larger scale too"
            (assertEqual (Ok Scalene) (triangleKind 10 11 12))
        , test "scalene triangles have no equal sides at a larger scale too 2"
            (assertEqual (Ok Scalene) (triangleKind 5 4 2))
        , test "very small triangles are legal"
            (assertEqual (Ok Scalene) (triangleKind 0.4 0.6 0.3))
        , test "triangles with no size are illegal"
            (assertEqual (Err "Invalid lengths") (triangleKind 0 0 0))
        , test "triangles with negative sides are illegal"
            (assertEqual (Err "Invalid lengths") (triangleKind 3 4 -5))
        , test "triangles violating triangle inequality are illegal 1"
            (assertEqual (Err "Violates inequality") (triangleKind 1 1 3))
        , test "triangles violating triangle inequality are illegal 2"
            (assertEqual (Err "Violates inequality") (triangleKind 2 4 2))
        , test "triangles violating triangle inequality are illegal 3"
            (assertEqual (Err "Violates inequality") (triangleKind 7 3 2))
        ]


main : Program Never
main =
    runSuite tests
