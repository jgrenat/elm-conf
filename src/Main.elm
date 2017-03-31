module Main exposing (..)

import Html exposing (Html, button, div, h1, p, program, text)
import Html.Events exposing (onClick)


triesNumber : Int
triesNumber =
    6


main : Program Never Model Msg
main =
    program { init = init, view = view, update = update, subscriptions = (\m -> Sub.none) }


type alias Model =
    {}


type Msg
    = None


init =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Guess The Number" ]
        , p []
            [ text <| "You have " ++ (toString triesNumber) ++ " tries to guess a number. Are you ready?" ]
        , button [] [ text "Start Game" ]
        ]
