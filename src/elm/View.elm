module View exposing (view)
import Model exposing (Model)
import Update exposing (..)
import Html exposing (..)
import Selection
import Styles exposing (..)

view : Model -> Html Msg
view model =
  div [] [
    div [ styles.buffer ] [ -- CONTENT
        pre [styles.text] [text model.content]
        -- map each selection through the selection renderer
      , div [] <| List.map (Selection.render (model.content)) model.selections
    ]
    , div [] [text (toString model)]
  ]
