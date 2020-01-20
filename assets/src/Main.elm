module Main exposing (main)
import Html exposing (Html, text, div, p, h1)
import Html.Attributes exposing (attribute)

import List exposing (..)


import Day1 exposing (day1)

-- Idiomatic Helpers
className = attribute "class"

-- Output a given day of Advent of Code
renderDay : Int -> (String, String, Html msg) -> Html msg
renderDay dayNum (part1, part2, visualization) =
  div [ className "day" ]
  [
    h1 [] [ text <| "Day " ++ String.fromInt (dayNum + 1) ]
  , div [ className "day-wrapper" ] 
    [
      div [ className "source-code" ] []
    , div [ className "result" ] 
      [
        p [ className "part1" ] [
          text "Part 1: "
        , text part1
        ]
      , p [ className "part2" ] [
          text "Part 2: "
        , text part2
        ]
      , div [ className "visualization" ] [
          visualization
        ]
      ]
    ]
  ]

main = [ day1 ] 
  |> indexedMap renderDay 
  |> div [ attribute "class" "advent-of-code" ]

-- TODO: for each day render:
-- * part 1 answer
-- * part 2 answer
-- * source code (highlighted as Elm)
-- * optionally, a visualization
