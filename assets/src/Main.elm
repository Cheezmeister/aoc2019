module Main exposing (main)
import Html exposing (Html, text, div, p)
import Html.Attributes exposing (attribute)

import List exposing (..)


import Day1 exposing (day1)

-- Output a given day of Advent of Code
renderDay : (String, String, Html msg) -> Html msg
renderDay (part1, part2, visualization) =
  div [ attribute "class" "day" ]
  [
    p [ attribute "class" "part1" ] [
      text "Part 1: "
    , text part1
    ]
  , p [ attribute "class" "part2" ] [
      text "Part 2: "
    , text part2
    ]
  , div [ attribute "class" "visualization" ] [
      visualization
    ]
  ]
 
main = renderDay day1

-- TODO: for each day render:
-- * part 1 answer
-- * part 2 answer
-- * source code (highlighted as Elm)
-- * optionally, a visualization
