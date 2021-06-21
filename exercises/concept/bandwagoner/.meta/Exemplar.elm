module Bandwagoner exposing (..)


type alias Coach =
    { name : String
    , formerPlayer : Bool
    }


type alias Stats =
    { wins : Int
    , losses : Int
    }


type alias Team =
    { name : String
    , coach : Coach
    , stats : Stats
    }


replaceCoach : Coach -> Team -> Team
replaceCoach newCoach team =
    { team | coach = newCoach }


isSameTeam : Team -> Team -> Bool
isSameTeam homeTeam awayTeam =
    homeTeam == awayTeam


rootForTeam : { a | stats : Stats } -> Bool
rootForTeam { stats } =
    stats.wins > stats.losses
