module Model exposing (Model, model)
import Selection exposing (Selection)

type alias Model =
  {
      selections : List Selection
    , content : String
  }

-- MODEL
-- Those are dummy selections to play around with.
multiLineSelection : Selection
multiLineSelection =
  {
      start = (3, 5)
    , end = (6, 1)
  }
singleLineSelection : Selection
singleLineSelection =
  {
      start = (1, 2)
    , end = (1, 10)
  }


model : Model
model = 
  {
      selections = [ singleLineSelection, multiLineSelection ]
    , content = "Hello World\n You are pretty\nHello World\n You are pretty\nHello World\n You are pretty\nHello World\n You are pretty\n"
  }

