module Element.HslTests exposing (..)

import Element.Hsl as Hsl
import Expect
import Test exposing (Test)


hslToRgb : Test
hslToRgb =
    Test.describe "HSL values should compute to the expected RGB values" <|
        List.map expectAreEqual
            [ ( Hsl 215 1 0.48, Rgb 242 102 245 )
            , ( Hsl 30 1 0.7, Rgb 255 179 102 )
            , ( Hsl 95 1 0.7, Rgb 166 255 102 )
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
