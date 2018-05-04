module View exposing (view)

import Html exposing (Html, h1, div, label, text, span, strong, form, input)
import Html.Attributes exposing (class, value)
import Html.Events exposing (onInput, onBlur)
import Round
import Validation exposing (Field, rawValue, extractError)
import Model exposing (Model)
import Types exposing (Msg(..))


view : Model -> Html Msg
view model =
    div
        []
        [ head model
        , body model
        , footer model
        ]


head : Model -> Html Msg
head model =
    div
        [ class "grid-container" ]
        [ div
            [ class "grid-x grid-margin-x" ]
            [ h1 [ class "cell" ] [ text "Fuel consumption" ] ]
        ]


body : Model -> Html Msg
body model =
    form
        []
        [ div
            [ class "grid-container" ]
            [ inputField "Distance" "km" InputDistance BlurDistance model.distance
            , inputField "Fueled" "l" InputFueled BlurFueled model.fueled
            , result model
            ]
        ]


footer : Model -> Html Msg
footer model =
    div [] []


inputField : String -> String -> (String -> Msg) -> Msg -> Field String a -> Html Msg
inputField label_ unit onInput_ onBlur_ field =
    div
        [ class "grid-x grid-margin-x" ]
        [ div
            [ class "cell small-9" ]
            [ label [] [ text label_ ]
            , showError field
            , div
                [ class "input-group" ]
                [ input
                    [ class "input-group-field"
                    , onInput onInput_
                    , onBlur onBlur_
                    , value (rawValue field)
                    ]
                    []
                , span
                    [ class "input-group-label" ]
                    [ text unit ]
                ]
            ]
        ]


showError : Field raw a -> Html msg
showError field =
    case extractError (field) of
        Just msg ->
            div
                [ class "callout small alert" ]
                [ text msg ]

        Nothing ->
            text ""


result : { m | consumption : Maybe Float } -> Html Msg
result { consumption } =
    let
        markup =
            case consumption of
                Just value ->
                    div
                        [ class "callout" ]
                        [ text ("Average consumption is " ++ (Round.round 2 value) ++ " liters per 100 km.") ]

                Nothing ->
                    div
                        [ class "callout warning" ]
                        [ text "Please enter the values for the calculation." ]
    in
        div
            [ class "grid-x grid-margin-x" ]
            [ div
                [ class "cell small-9" ]
                [ strong [] [ markup ] ]
            ]
