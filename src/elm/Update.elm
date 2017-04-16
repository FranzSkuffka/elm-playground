module Update exposing ( Msg, subscriptions, update )
import SelectionUpdate
import Model exposing ( Model )
import Keyboard

-- UPDATE
type Msg = KeyMsg Keyboard.KeyCode

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ Keyboard.downs KeyMsg ]

update : Msg -> Model -> ( Model, Cmd msg )
update msg model =
  case msg of
    KeyMsg code -> ((SelectionUpdate.processKeyCode code model), Cmd.none)
