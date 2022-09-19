module CircularBuffer exposing (CircularBuffer, clear, new, overwrite, read, write)


type CircularBuffer a
    = Todo


new : Int -> CircularBuffer a
new size =
    Debug.todo "Please implement this function"


write : a -> CircularBuffer a -> Maybe (CircularBuffer a)
write element buffer =
    Debug.todo "Please implement this function"


overwrite : a -> CircularBuffer a -> CircularBuffer a
overwrite element buffer =
    Debug.todo "Please implement this function"


read : CircularBuffer a -> Maybe ( a, CircularBuffer a )
read buffer =
    Debug.todo "Please implement this function"


clear : CircularBuffer a -> CircularBuffer a
clear buffer =
    Debug.todo "Please implement this function"
