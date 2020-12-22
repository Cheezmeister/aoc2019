module Day1 exposing (day1)

import List exposing (..)
import Html exposing (Html, text, div, p)

-- TODO: Read this from not code
myInput = """
139301
84565
124180
133902
138726
62665
142967
95598
118044
73234
76476
51634
71582
63619
148430
134733
101537
101140
144543
102233
62048
128633
130113
92531
73820
54964
103485
96364
104119
121954
79215
99235
120179
69237
145584
79193
50684
146481
67783
112741
85024
62298
54083
137704
116561
76862
81410
96341
89992
132926
97955
74751
147553
121496
113303
119671
120871
114278
125628
144275
78826
87092
65883
87517
93974
55358
100922
113304
115728
144556
91728
86367
55283
101841
55454
140703
70706
98173
106920
126984
148960
77909
128304
140036
81044
141419
126770
52787
115783
128647
125986
124506
113935
142203
106404
78433
146573
68575
63563
115616
"""

-- TODO: Factor into util module
-- Unwrap a Maybe
really : Maybe number -> number
really val =
  case val of
    Just some -> some
    Nothing -> 0


-- Calculate base fuel
baseFuel : Int -> Int
baseFuel n =
  n // 3 - 2 |> max 0

-- Calculate fuel recursively for part 2
fuel : Int -> Int
fuel n =
  let
    val = baseFuel n
  in
  if val <= 0 then 0 else val + fuel val

solve : String -> (String, String, Html msg)
solve input =
  let
    modules =
      String.split "\n" input |> map (String.toInt >> really)
    totalPart1Fuel =
      map baseFuel modules |> (foldr (+) 0)
    totalFuel =
      map fuel modules |> (foldr (+) 0)
    viz =
      div []
      [
        text "This is day 1's 'visualization'"
      , p [] [text <| (map baseFuel modules |> map String.fromInt |> String.join ",") ]
      , p [] [text <| String.fromInt <| baseFuel 139301 ]
      , p [] [text <| String.fromInt totalFuel]
      ]

  in
    (totalPart1Fuel |> String.fromInt, totalFuel |> String.fromInt, viz)

day1 dummy =
  solve myInput
