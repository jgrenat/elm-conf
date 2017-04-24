module Main exposing (..)

import Html exposing (Html, button, div, p, program, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Random


main : Program Never Model Msg
main =
    program { init = init, view = view, update = update, subscriptions = (\m -> Sub.none) }


type Model
    = NoGame
    | Game CoinState
    | Result GameStart


type GameStart
    = Win
    | Loss


type CoinState
    = Heads
    | Tails


type Msg
    = FlipCoin
    | CoinFlipped CoinState
    | PlayerBet CoinState


init : ( Model, Cmd Msg )
init =
    ( NoGame, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FlipCoin ->
            ( model, Random.generate CoinFlipped randomCoin )

        CoinFlipped coinState ->
            ( Game coinState, Cmd.none )

        PlayerBet bet ->
            let
                result =
                    if model == Game bet then
                        Win
                    else
                        Loss
            in
                ( Result result, Cmd.none )


randomCoin : Random.Generator CoinState
randomCoin =
    Random.map
        (\b ->
            if b then
                Heads
            else
                Tails
        )
        Random.bool


view : Model -> Html Msg
view model =
    case model of
        NoGame ->
            div []
                [ startGameButton ]

        Game _ ->
            div []
                [ p [] [ text "Heads or Tails?" ]
                , button [ class "btn btn-default", onClick (PlayerBet Heads) ] [ text "Heads" ]
                , text " "
                , button [ class "btn btn-default", onClick (PlayerBet Tails) ] [ text "Tails" ]
                ]

        Result state ->
            let
                result =
                    if state == Win then
                        "Congrat's, you were right!"
                    else
                        "You failed..."
            in
                div []
                    [ p [] [ text result ]
                    , startGameButton
                    ]


startGameButton : Html Msg
startGameButton =
    button [ class "btn btn-primary", onClick FlipCoin ] [ text "Start a new game" ]
