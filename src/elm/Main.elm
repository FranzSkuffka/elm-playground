port module Main exposing (..)
import Json.Decode exposing (Decoder, decodeValue, succeed, string)


import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (..)


main : Program Never Model Msg
main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model =
  { word : String
  , suggestions : List String
  , items : List String
  }

init : (Model, Cmd Msg)
init =
  (Model "" [] [], Cmd.none)



type alias Item =
  {
    title : String
  }


-- UPDATE
type Msg
  = Change String
  | Create
  | Suggest (List String)
  | ShowItems (List Json.Decode.Value)


port create : String -> Cmd msg

decodeItem : Value -> String
decodeItem item =
  case (decodeValue (field "title" string)) item of
    Ok title -> title
    Err msg -> "Could not read data of item"

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    ShowItems items ->
      ( Model "" [] (List.map decodeItem items), Cmd.none)
    Change newWord ->
      ( Model newWord [] [], Cmd.none )

    Create ->
      ( Model model.word [] [], create model.word )

    Suggest newSuggestions ->
      ( Model model.word newSuggestions [], Cmd.none )


-- SUBSCRIPTIONS

port suggestions : (List String -> msg) -> Sub msg

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch [
      suggestions Suggest
    , items ShowItems
  ]

port items : ( List Json.Decode.Value -> msg ) -> Sub msg


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ onInput Change ] []
    , button [ onClick Create ] [ text "Create" ]
    , div [] [ text (String.join ", " model.suggestions) ]
    , div [] [ text (toString model.items)]
    ]
