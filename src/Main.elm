module Main exposing (..)

import Html exposing (beginnerProgram, text, Html)


main : Program Never String a
main =
    beginnerProgram { model = model, view = view, update = update }


model : String
model =
    "Devoxx"


update : a -> String -> String
update msg model =
    model


view : String -> Html a
view model =
    text ("Hello " ++ model ++ "!")
