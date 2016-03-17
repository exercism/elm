module SpaceAgeExample where

type Planet = Mercury
            | Venus
            | Earth
            | Mars
            | Jupiter
            | Saturn
            | Uranus
            | Neptune


earthYearInSeconds = 365.25 * 24 * 60 * 60

ageOn : Planet -> Float -> Float
ageOn planet seconds = seconds / (secondsPerYear planet)

secondsPerYear : Planet -> Float
secondsPerYear planet =
  earthYearInSeconds * case planet of
    Mercury -> 0.2408467
    Venus   -> 0.61519726
    Earth   -> 1
    Mars    -> 1.8808158
    Jupiter -> 11.862615
    Saturn  -> 29.447498
    Uranus  -> 84.016846
    Neptune -> 164.79132
