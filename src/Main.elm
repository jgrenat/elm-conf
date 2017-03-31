module Main exposing (..)

import Html exposing (Html, button, div, h1, input, p, program, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (onClick)
import Random exposing (int)


triesNumber : Int
triesNumber =
    6


main : Program Never Model Msg
main =
    program { init = init, view = view, update = update, subscriptions = (\m -> Sub.none) }


type Model
    = NoGame
    | Game GameData
    | Result Bool Int


type Msg
    = StartNewGame
    | GameStarted Int
    | PlayerTry String
    | GameEnded Bool Int
    | None


type alias GameData =
    { number : Int
    , remainingTries : Int
    , lastTry : Maybe Int
    }


init =
    ( NoGame, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartNewGame ->
            ( model, Random.generate GameStarted <| Random.int 1 100 )

        GameStarted number ->
            ( Game <| GameData number triesNumber Nothing, Cmd.none )

        PlayerTry try ->
            ( model, Cmd.none )

        GameEnded result remainingTries ->
            ( model, Cmd.none )

        None ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    case model of
        NoGame ->
            noGame

        Game gameData ->
            game gameData

        Result result remainingTries ->
            noGame


noGame : Html Msg
noGame =
    div []
        [ h1 [] [ text "Guess The Number" ]
        , p []
            [ text <| "You have " ++ (toString triesNumber) ++ " tries to guess a number. Are you ready?" ]
        , button [ onClick StartNewGame ] [ text "Start Game" ]
        ]


game : GameData -> Html Msg
game gameData =
    div []
        [ p []
            [ text <|
                (toString gameData.remainingTries)
                    ++ " remaining tries. "
                    ++ showLast gameData
            ]
        , input [ type_ "text" ] []
        , button [] [ text "Guess" ]
        ]


showLast : GameData -> String
showLast gameData =
    case gameData.lastTry of
        Nothing ->
            ""

        Just try ->
            "Your last try was "
                ++ (toString try)
                ++ ". The number to guess is "
                ++ (if try < gameData.number then
                        "higher"
                    else
                        "lower"
                   )
                ++ " than your last try."
