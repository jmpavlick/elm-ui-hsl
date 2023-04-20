module Element.Hsl exposing (hsl, hsla, toRgb)

import Element


toRgb : { h : Int, s : Float, l : Float } -> { r : Int, g : Int, b : Int }
toRgb { h, s, l } =
    let
        hFloat : Float
        hFloat =
            Basics.toFloat h / 360

        hueToRgb : { p_ : Float, q_ : Float, t : Float } -> Float
        hueToRgb { p_, q_, t } =
            let
                minT : Float
                minT =
                    Basics.min t 1

                t_ : Float
                t_ =
                    if minT > 1 then
                        minT - 1

                    else
                        minT
            in
            if t_ < 1 / 6 then
                p_ + (q_ - p_) * 6 * t_

            else if t_ < 1 / 2 then
                q_

            else if t_ < 2 / 3 then
                p_ + (q_ - p_) * (2 / 3 - t_) * 6

            else
                p_

        q : Float
        q =
            if l < 0.5 then
                l * (1 + s)

            else
                l + s - l * s

        p : Float
        p =
            2 * l - q

        toHex : Float -> Int
        toHex =
            (*) 255 >> Basics.round

        pq : Float -> Int
        pq bOffset =
            hueToRgb { p_ = p, q_ = q, t = hFloat + bOffset }
                |> toHex
                |> Basics.max 0
    in
    if s == 0 then
        toHex l
            |> (\lHex ->
                    { r = lHex
                    , g = lHex
                    , b = lHex
                    }
               )

    else
        { r = pq (1 / 3)
        , g = pq 0
        , b = pq (Basics.negate 1 / 3) |> Basics.max 0
        }


hsl : { h : Int, s : Float, l : Float } -> Element.Color
hsl params =
    let
        { r, g, b } =
            toRgb params
    in
    Element.rgb255 r g b


hsla : { h : Int, s : Float, l : Float, a : Float } -> Element.Color
hsla { h, s, l, a } =
    let
        { r, g, b } =
            toRgb { h = h, s = s, l = l }
    in
    Element.rgba255 r g b a
