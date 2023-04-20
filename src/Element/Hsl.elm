module Element.Hsl exposing
    ( hsl
    , hsla
    , fromHsl
    , fromHsla
    , toRgb255
    )

{-| HSL colors for elm-ui.

@docs hsl

@docs hsla

@docs fromHsl

@docs fromHsla

@docs toRgb255

-}

import Element


{-| Create a color from hue, saturation, and lightness.
-}
hsl : Int -> Float -> Float -> Element.Color
hsl h s l =
    fromHsl { h = h, s = s, l = l }


{-| `hsl`, with named parameters. Nice for readability, if you're into that sort of thing.
-}
fromHsl : { h : Int, s : Float, l : Float } -> Element.Color
fromHsl params =
    let
        { r, g, b } =
            toRgb255 params
    in
    Element.rgb255 r g b


{-| Create a color from hue, saturation, lightness, and alpha (opacity).
-}
hsla : Int -> Float -> Float -> Float -> Element.Color
hsla h s l a =
    fromHsla { h = h, s = s, l = l, a = a }


{-| `hsla`, with named parameters. Nice for readability, if you're into that sort of thing.
-}
fromHsla : { h : Int, s : Float, l : Float, a : Float } -> Element.Color
fromHsla { h, s, l, a } =
    let
        { r, g, b } =
            toRgb255 { h = h, s = s, l = l }
    in
    Element.rgba255 r g b a


{-| Converts hue, saturation, and lightness to red, green, and blue, with each color represented by integers from `0` - `255`.
-}
toRgb255 : { h : Int, s : Float, l : Float } -> { r : Int, g : Int, b : Int }
toRgb255 { h, s, l } =
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
        , b = pq (Basics.negate 1 / 3)
        }
