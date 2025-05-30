module RelativeDistance exposing (degreeOfSeparation)

import Dict exposing (Dict)
import Set exposing (Set)


degreeOfSeparation : Dict String (List String) -> String -> String -> Maybe Int
degreeOfSeparation familyTree personA personB =
    let
        tree =
            bidirectionalTree familyTree
    in
    if Dict.member personA tree && Dict.member personB tree then
        findDegreeOfSeparation tree personA personB

    else
        Nothing


bidirectionalTree : Dict String (List String) -> Dict String (Set String)
bidirectionalTree familyTree =
    let
        addRelationship from to tree =
            Dict.update from
                (\maybeLinks ->
                    maybeLinks
                        |> Maybe.map (Set.insert to)
                        |> Maybe.withDefault (Set.singleton to)
                        |> Just
                )
                tree
    in
    familyTree
        |> Dict.map (always Set.fromList)
        |> Dict.foldl
            (\parent children graph ->
                Set.foldl
                    (\child acc ->
                        acc
                            |> addRelationship parent child
                            |> addRelationship child parent
                            |> (\links ->
                                    Set.foldl
                                        (\sibling -> addRelationship child sibling)
                                        links
                                        (Set.remove child children)
                               )
                    )
                    graph
                    children
            )
            Dict.empty


findDegreeOfSeparation : Dict String (Set String) -> String -> String -> Maybe Int
findDegreeOfSeparation familyTree personA personB =
    let
        initialQueue =
            [ ( personA, 0 ) ]

        initialVisited =
            Set.singleton personA
    in
    bfs familyTree initialQueue initialVisited personB


bfs : Dict String (Set String) -> List ( String, Int ) -> Set String -> String -> Maybe Int
bfs graph queue visited target =
    case queue of
        [] ->
            Nothing

        ( current, distance ) :: rest ->
            if current == target then
                Just distance

            else
                graph
                    |> Dict.get current
                    |> Maybe.andThen
                        (\connections ->
                            let
                                nextConnection next ( currentQueue, alreadyVisited ) =
                                    if Set.member next alreadyVisited then
                                        ( currentQueue, alreadyVisited )

                                    else
                                        ( currentQueue ++ [ ( next, distance + 1 ) ]
                                        , Set.insert next alreadyVisited
                                        )

                                ( newQueue, newVisited ) =
                                    Set.foldl nextConnection ( rest, visited ) connections
                            in
                            bfs graph newQueue newVisited target
                        )
