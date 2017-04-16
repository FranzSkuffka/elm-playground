-- Composition as container for complex operations
-- Example: split selection
-- Example: insert
-- Composition is part of model and can be applied to model
-- Model is split up in current and preview
-- When composition is applied, new model becomes current model
-- Undo also affects Selection

module Main exposing (..)
import Html exposing (..)
import View exposing (view)
import Model exposing (Model, model)
import Update exposing (..)

-- APP
main : Program Never Model Msg
main =
    Html.program
      { init = init
      , view = view
      , update = update
      , subscriptions = subscriptions
      }

init : ( Model, Cmd Msg )
init = ( model, Cmd.none )
