# elm-ui-hsl

Do you like [elm-ui](https://package.elm-lang.org/packages/mdgriffith/elm-ui/latest/)? Do you prefer HSL to RGB?

Check this out:

```
import Element
import Element.Hsl as Hsl


purple : Element.Color
purple =
    Hsl.hsl 272 0.63 0.5

cyan : Element.Color
cyan =
    Hsl.fromHsl { h = 185, s = 0.79, l = 0.5 }


transparentBlue : Element.Color
transparentBlue =
    Hsl.hsla 237 0.79 0.5 0.49


transparentPink : Element.Color
transparentPink =
    Hsl.fromHsla { h = 312, s = 0.79, l = 0.5, a = 0.57 }
```

That's it, that's all it takes.