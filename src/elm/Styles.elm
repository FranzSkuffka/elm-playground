module Styles exposing (styles, lineHeight)
import CssHelpers exposing (..)
import Html.Attributes exposing (..)
import Html exposing (..)


-- Lineheight is rendering-specific, selection parts must be adjusted to line height in buffer
lineHeight : Int
lineHeight = 60

styles : { buffer : Attribute msg, text : Attribute msg1 }
styles = {
    buffer = style [
        ("font-family", "monospace")
      , ("line-height", toPixel lineHeight )
    ]
  , text = style [
        ("z-index", "200")
      , ("position", "relative")
    ]
  }

