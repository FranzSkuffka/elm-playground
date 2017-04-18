port module Firebase exposing (..)

-- port for sending strings out to JavaScript
port check : String -> Cmd msg

type Msg = String
-- port for listening for suggestions from JavaScript
port suggestions : (String -> msg) -> Sub msg
