module Tests exposing (tests)

import CircularBuffer
import Expect
import Test exposing (Test, describe, skip, test)


type Operation a
    = Read
    | Write a
    | Overwrite a
    | Clear


type Output a
    = ReadSuccess a
    | ReadFailure
    | WriteSuccess
    | WriteFailure


run : Int -> List (Operation a) -> List (Output a)
run size =
    let
        runOperation operation ( buffer, output ) =
            case operation of
                Read ->
                    case CircularBuffer.read buffer of
                        Just ( a, newBuffer ) ->
                            ( newBuffer, ReadSuccess a :: output )

                        Nothing ->
                            ( buffer, ReadFailure :: output )

                Write element ->
                    case CircularBuffer.write element buffer of
                        Just newBuffer ->
                            ( newBuffer, WriteSuccess :: output )

                        Nothing ->
                            ( buffer, WriteFailure :: output )

                Overwrite element ->
                    ( CircularBuffer.overwrite element buffer, output )

                Clear ->
                    ( CircularBuffer.clear buffer, output )
    in
    List.foldl runOperation ( CircularBuffer.new size, [] )
        >> Tuple.second
        >> List.reverse


tests : Test
tests =
    describe "CircularBuffer"
        [ -- skip <|
          test "reading empty buffer should fail" <|
            \() ->
                run 1 [ Read ]
                    |> Expect.equal [ ReadFailure ]
        , skip <|
            test "can read an item just written" <|
                \() ->
                    run 1 [ Write 1, Read ]
                        |> Expect.equal [ WriteSuccess, ReadSuccess 1 ]
        , skip <|
            test "each item may only be read once" <|
                \() ->
                    run 1 [ Write 1, Read, Read ]
                        |> Expect.equal [ WriteSuccess, ReadSuccess 1, ReadFailure ]
        , skip <|
            test "items are read in the order they are written" <|
                \() ->
                    run 2 [ Write 1, Write 2, Read, Read ]
                        |> Expect.equal [ WriteSuccess, WriteSuccess, ReadSuccess 1, ReadSuccess 2 ]
        , skip <|
            test "full buffer can't be written to" <|
                \() ->
                    run 1 [ Write 1, Write 2 ]
                        |> Expect.equal [ WriteSuccess, WriteFailure ]
        , skip <|
            test "a read frees up capacity for another write" <|
                \() ->
                    run 1 [ Write 1, Read, Write 2, Read ]
                        |> Expect.equal [ WriteSuccess, ReadSuccess 1, WriteSuccess, ReadSuccess 2 ]
        , skip <|
            test "read position is maintained even across multiple writes" <|
                \() ->
                    run 3 [ Write 1, Write 2, Read, Write 3, Read, Read ]
                        |> Expect.equal
                            [ WriteSuccess
                            , WriteSuccess
                            , ReadSuccess 1
                            , WriteSuccess
                            , ReadSuccess 2
                            , ReadSuccess 3
                            ]
        , skip <|
            test "items cleared out of buffer can't be read" <|
                \() ->
                    run 1 [ Write 1, Clear, Read ]
                        |> Expect.equal [ WriteSuccess, ReadFailure ]
        , skip <|
            test "clear frees up capacity for another write" <|
                \() ->
                    run 1 [ Write 1, Clear, Write 2, Read ]
                        |> Expect.equal [ WriteSuccess, WriteSuccess, ReadSuccess 2 ]
        , skip <|
            test "clear does nothing on empty buffer" <|
                \() ->
                    run 1 [ Clear, Write 1, Read ]
                        |> Expect.equal [ WriteSuccess, ReadSuccess 1 ]
        , skip <|
            test "overwrite acts like write on non-full buffer" <|
                \() ->
                    run 2 [ Write 1, Overwrite 2, Read, Read ]
                        |> Expect.equal [ WriteSuccess, ReadSuccess 1, ReadSuccess 2 ]
        , skip <|
            test "overwrite replaces the oldest item on full buffer" <|
                \() ->
                    run 2 [ Write 1, Write 2, Overwrite 3, Read, Read ]
                        |> Expect.equal [ WriteSuccess, WriteSuccess, ReadSuccess 2, ReadSuccess 3 ]
        , skip <|
            test "overwrite replaces the oldest item remaining in buffer following a read" <|
                \() ->
                    run 3 [ Write 1, Write 2, Write 3, Read, Write 4, Overwrite 5, Read, Read, Read ]
                        |> Expect.equal
                            [ WriteSuccess
                            , WriteSuccess
                            , WriteSuccess
                            , ReadSuccess 1
                            , WriteSuccess
                            , ReadSuccess 3
                            , ReadSuccess 4
                            , ReadSuccess 5
                            ]
        , skip <|
            test "initial clear does not affect wrapping around" <|
                \() ->
                    run 2 [ Clear, Write 1, Write 2, Overwrite 3, Overwrite 4, Read, Read, Read ]
                        |> Expect.equal
                            [ WriteSuccess
                            , WriteSuccess
                            , ReadSuccess 3
                            , ReadSuccess 4
                            , ReadFailure
                            ]
        , skip <|
            test "buffer can store strings" <|
                \() ->
                    run 2 [ Write "hello", Write "goodbye", Read, Read ]
                        |> Expect.equal
                            [ WriteSuccess
                            , WriteSuccess
                            , ReadSuccess "hello"
                            , ReadSuccess "goodbye"
                            ]
        ]
