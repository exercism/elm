module CircularBuffer exposing (CircularBuffer, clear, new, overwrite, read, write)


type alias CircularBuffer a =
    { size : Int, currentFill : Int, input : List a, output : List a }


new : Int -> CircularBuffer a
new size =
    CircularBuffer size 0 [] []


write : a -> CircularBuffer a -> Maybe (CircularBuffer a)
write element ({ size, currentFill, input } as circularBuffer) =
    if currentFill == size then
        Nothing

    else
        Just { circularBuffer | currentFill = currentFill + 1, input = element :: input }


overwrite : a -> CircularBuffer a -> CircularBuffer a
overwrite element ({ size, currentFill, input, output } as circularBuffer) =
    case ( currentFill == size, output ) of
        ( True, [] ) ->
            overwrite element { circularBuffer | output = List.reverse input, input = [] }

        ( True, _ ) ->
            { circularBuffer | output = List.drop 1 output, input = element :: input }

        _ ->
            { circularBuffer | currentFill = currentFill + 1, input = element :: input }


read : CircularBuffer a -> Maybe ( a, CircularBuffer a )
read ({ currentFill, input, output } as circularBuffer) =
    case ( currentFill, output ) of
        ( 0, _ ) ->
            Nothing

        ( _, [] ) ->
            read { circularBuffer | output = List.reverse input, input = [] }

        ( _, element :: rest ) ->
            Just ( element, { circularBuffer | currentFill = currentFill - 1, output = rest } )


clear : CircularBuffer a -> CircularBuffer a
clear { size } =
    new size
