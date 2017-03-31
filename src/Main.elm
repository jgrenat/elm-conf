module Main exposing (..)

import Html exposing (Html, button, div, program, text)
import Html.Attributes exposing (class)


main : Program Never Model Msg
main =
    program { init = init, view = view, update = update, subscriptions = (\m -> Sub.none) }


type Model
    = NoGame


type Msg
    = None


init =
    ( NoGame, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ startGameButton ]


startGameButton : Html Msg
startGameButton =
    button [ class "btn btn-primary" ] [ text "Start a new game" ]
