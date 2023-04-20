module Element.HslTests exposing (..)

import Element.Hsl as Hsl
import Expect
import Test exposing (Test)


hslToRgb : Test
hslToRgb =
    Test.describe "HSL values should compute to the expected RGB values" <|
        List.map expectAreEqual
            [ ( Hsl 50 1 0.5, Rgb 255 213 0 )
            , ( Hsl 104 1 0.5, Rgb 68 255 0 )
            , ( Hsl 188 0.65 0.43, Rgb 38 162 181 )
            , ( Hsl 272 0.65 1, Rgb 255 255 255 )
            , ( Hsl 360 0 0, Rgb 0 0 0 )
            ]


type alias Hsl =
    { h : Int, s : Float, l : Float }


type alias Rgb =
    { r : Int, g : Int, b : Int }


expectAreEqual : ( Hsl, Rgb ) -> Test
expectAreEqual ( { h, s, l }, { r, g, b } ) =
    Test.test
        (String.join " "
            [ "HSL"
            , String.fromInt h
            , String.fromFloat s
            , String.fromFloat l
            , "should equal RGB"
            , String.fromInt r
            , String.fromInt g
            , String.fromInt b
            ]
        )
    <|
        \() ->
            Hsl.toRgb255 { h = h, s = s, l = l } |> Expect.equal { r = r, g = g, b = b }
