module Selection exposing (Selection, Position, render)
import Html exposing (..)
import Html.Attributes exposing (..)
import CssHelpers exposing (..)

lineHeight : number
lineHeight = 60


type alias Line = Int
type alias Column = Int
-- Position: a pair of coordinates. can be used for relative or absolute transformations
type alias Position = (Line, Column)
-- start / end = (line, column)
type alias Selection =
  {
      start : Position
    , end : Position
  }


styles = {
    selectionLine = [
        ("background-color", "#ccc")
      , ("height", toPixel lineHeight)
      , ("position", "relative")
      , ("color", "transparent")
    ]
  , selection = [
        ("z-index", "100")
      , ("position", "absolute")
    ]
  }



render : String -> Selection -> Html msg
render buffer selection =
  let
    bufferLines = String.lines buffer
    selectionLines = calculateSelectionLines bufferLines selection
    top = lineHeight * ((Tuple.first selection.start) - 1)
    position = [("top", toPixel top)]
    layout = List.concat [styles.selection, position]
  in
    div [style layout] <| List.map renderSelectionLine selectionLines

-- Selection line consists of start & end of the highlight on a specific line
type alias SelectionLine = (Int, Int)

-- calculateSelectionLines
calculateSelectionLines : List String -> Selection -> List SelectionLine
calculateSelectionLines bufferLines selection =
  let
    selectionLineRange = List.range (Tuple.first selection.start) (Tuple.first selection.end)
    -- all lines except first start at 0, first one starts at first selection.start x coord
    lineStarts = List.repeat (List.length selectionLineRange) 0
      |> List.tail
      |> Maybe.withDefault []
      |> (::) (Tuple.second selection.start)
    lineEnds = bufferLines
      |> List.map String.length
      |> List.drop (Maybe.withDefault 0 (List.head selectionLineRange) + 1)
      |> List.take ((List.length selectionLineRange) - 1)
      |> List.reverse
      |> (::) (Tuple.second selection.end)
      |> List.reverse
  in
    -- determine if is single-line selection
    -- if single-line selection, calculate single selection line
    if List.length selectionLineRange == 1 then
      [((Tuple.second selection.start), (Tuple.second selection.end))]
    else
      -- else calculate array of lines
      List.map2 (\start end -> (start, end)) lineStarts lineEnds

renderSelectionLine : SelectionLine -> Html msg
renderSelectionLine selectionLine =
  let
    layout = [
        ("left", toCh (Tuple.first selectionLine))
      , ("width", toCh (((Tuple.second selectionLine) - (Tuple.first selectionLine))))
    ]
    colorAndLayout = List.concat [layout, styles.selectionLine]
  in
    div [style colorAndLayout] [text <| toString <| selectionLine]