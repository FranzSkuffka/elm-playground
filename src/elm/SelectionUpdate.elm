module SelectionUpdate exposing ( processKeyCode )
import Selection exposing (..)
import Model exposing (..)
import Keyboard

processKeyCode : Int -> Model -> Model
processKeyCode code model =
  { model | selections = List.map (keyToMutator code (String.lines model.content) ) model.selections }


line : ( a1, a2 ) -> a1
line = Tuple.first

column : ( a1, a2 ) -> a2
column   = Tuple.second

change : IntOperator -> Position -> Position -> Position
change operator position difference =
  (
      operator ( line position ) ( line difference )
    , operator ( column position ) ( column difference )
  )


-- DATA TYPE ALIASES FOR BETTER NOTATIONS
type alias IntOperator = Int -> Int -> Int
type alias BufferLines = List String
type alias SelectionMutator = BufferLines -> Selection -> Selection
type Boundary = Start | End | Both


modifySelectionBoundary : Boundary -> IntOperator -> Position -> SelectionMutator
modifySelectionBoundary boundary operator operand bufferLines selection =
  let
    newSelection =
      case boundary of
        Start -> { selection | start = change operator selection.start operand }
        End   -> { selection | end = change operator selection.end operand }
        Both  -> { selection
          | start = change operator selection.start operand
          , end = change operator selection.end operand }
  in newSelection |> guardSelectionChange bufferLines

-- guard selection - prevent selection change from reaching out of buffer
-- behavour should be similiar to that of other text editor
-- this is an identity stub
guardSelectionChange bufferLines selection = selection
-- guard selection render
-- prevent selection from rendering longer than line
-- this can occur when a selection from a longer line is moved on the Y axis.
-- this is an identity stub
guardSelectionRender bufferLines selection = selection


keepSelection : SelectionMutator
keepSelection bufferLines selection = selection

keyToMutator : Int -> SelectionMutator
keyToMutator key =
  let
    keyMap = [
        (74, modifySelectionBoundary Both (+) (1, 0)) -- UP
      , (75, modifySelectionBoundary Both (-) (1, 0)) -- DOWN
      , (76, modifySelectionBoundary Both (+) (0, 1)) -- LEFT
      , (72, modifySelectionBoundary Both (-) (0, 1)) -- RIGHT
    ]
    getKey = Tuple.first
  in
    keyMap
      |> List.filter (\mapping ->  (mapping |> getKey) == key)
      |> List.map Tuple.second
      |> List.head
      |> Maybe.withDefault keepSelection
