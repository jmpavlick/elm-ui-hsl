module Main exposing (..)

import Html
import Element.Hsl as Hsl
import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border

main =
    rainbowShift
        |> List.map block
        |> Element.column [ Element.spacing 10 ]
        |> Element.layout []
        |> Html.map never


block : Element.Color -> Element Never
block color =
    Element.row []
        [ Element.el
            [ Element.width <| Element.px 210
            , Element.height <| Element.px 32
            , Border.rounded 10
            , Background.color color
            ]
          <|
            Element.none
        ]


rainbowShift : List Element.Color
rainbowShift =
    let
        start : Int
        start =
            0

        steps : Int
        steps =
            (360 - start) // 5

        range : List Int
        range =
            List.range 1 steps
                |> List.map (\step -> step * 5 + start)
    in
    List.map (\hue -> Hsl.hsl hue 1 0.7) range
