module Main exposing (main)
import Html exposing (Html, text, div, p, h1, pre)
import Html.Attributes exposing (attribute)
import Http
import Browser

import List exposing (..)


import Day1 exposing (day1)

-- Idiomatic Helpers
className = attribute "class"

-- TODO: Factor into util module
zip : List a -> List b -> List (a,b)
zip =
  List.map2 Tuple.pair

-- Output a given day of Advent of Code
renderDay : String -> String -> Int -> (String, String, Html msg) -> Html msg
renderDay solve input day1text dayNum =
  let
    -- input = List.get dayNum inputs
    (part1, part2, visualization) = solve input
  in
    div [ className "day" ]
    [
      h1 [] [ text <| "Day " ++ String.fromInt (dayNum + 1) ]
    , div [ className "day-wrapper" ] 
      [
        div [ className "source-code" ]
        [
          pre [] [ text day1text ]
        ]
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

day1render : String -> List String  -> Html msg
day1render day1text inputs = [ day1 ]
  |> zip inputs
  |> indexedMap (\solve input -> (renderDay solve input day1text))
  |> div [ attribute "class" "advent-of-code" ]

main = Browser.element
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

type alias Model =
  { flags: Flags
  , state: State
  }

type State
  = Failure
  | Loading
  | Success String

type Flags = List String

init : Flags -> (Model, Cmd Msg)
init flags =
  ( Model { flags = flags, state = Loading }
  , (Http.get
      { url = "/elm/Day1.elm"
      , expect = Http.expectString GotText
      }) flags
  )

type Msg
  = GotText (Result Http.Error String)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GotText result ->
      case result of
        Ok fullText ->
          ({ flags = model.flags, state = Success fullText }, Cmd.none)

        Err _ ->
          ({ flags = model.flags, state = Failure }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


view : Model -> Html Msg
view model =
  case model.state of
    Failure ->
      text "Something really bad happened!"

    Loading ->
      text "Loading..." -- TODO: Make this fancy animated thing

    Success fullText ->
      let
        inputsFromJs = model.flags
      in
        day1render fullText inputsFromJs
