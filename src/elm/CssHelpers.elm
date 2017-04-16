module CssHelpers exposing (toCh, toPixel)

type alias ToCssUnitString = Int -> String


-- CSS HELPER FUNCTIONS
toPixel : ToCssUnitString
toPixel number = toCssUnit "px" number

toCh : ToCssUnitString
toCh number = toCssUnit "ch" number

toCssUnit : String -> Int -> String
toCssUnit unit content =
  (toString content) ++ unit

