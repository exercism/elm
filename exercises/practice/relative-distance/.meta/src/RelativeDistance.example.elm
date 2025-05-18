module RelativeDistance exposing (degreeOfSeparation)

import Dict exposing (Dict)
import Set exposing (Set)


degreeOfSeparation : Dict String (List String) -> String -> String -> Int
degreeOfSeparation familyTree personA personB =
    let
        tree =
            bidirectionalTree familyTree
    in
    if Dict.member personA tree && Dict.member personB tree then
        findDegreeOfSeparation tree personA personB

    else
        -1


bidirectionalTree : Dict String (List String) -> Dict String (List String)
bidirectionalTree familyTree =
    let
        addRelationship from to tree =
            Dict.update from
                (\maybeLinks ->
                    case maybeLinks of
                        Nothing ->
                            Just [ to ]

                        Just links ->
                            if List.member to links then
                                Just links

                            else
                                Just (to :: links)
                )
                tree
    in
    Dict.foldl
        (\parent children graph ->
            List.foldl
                (\child acc ->
                    acc
                        |> addRelationship parent child
                        |> addRelationship child parent
                        |> (\links ->
                                List.foldl
                                    (\sibling -> addRelationship child sibling)
                                    links
                                    (List.filter (\c -> c /= child) children)
                           )
                )
                graph
                children
        )
        Dict.empty
        familyTree


findDegreeOfSeparation : Dict String (List String) -> String -> String -> Int
findDegreeOfSeparation familyTree personA personB =
    let
        initialQueue =
            [ ( personA, 0 ) ]

        initialVisited =
            Set.singleton personA
    in
    bfs familyTree initialQueue initialVisited personB


bfs : Dict String (List String) -> List ( String, Int ) -> Set String -> String -> Int
bfs graph queue visited target =
    case queue of
        [] ->
            -1

        -- out of connections
        ( current, distance ) :: rest ->
            if current == target then
                distance

            else
                case Dict.get current graph of
                    Nothing ->
                        bfs graph rest visited target

                    -- dead end --
                    Just connections ->
                        let
                            nextConnection next ( currentQueue, alreadyVisited ) =
                                if Set.member next alreadyVisited then
                                    ( currentQueue, alreadyVisited )

                                else
                                    ( currentQueue ++ [ ( next, distance + 1 ) ]
                                    , Set.insert next alreadyVisited
                                    )

                            ( newQueue, newVisited ) =
                                List.foldl nextConnection ( rest, visited ) connections
                        in
                        bfs graph newQueue newVisited target
