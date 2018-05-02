module Main exposing (main)

import Html
import View exposing (view)
import Update exposing (update)
import Model exposing (init)
import Types exposing (Msg(..))
import Model exposing (Model)


main : Program Never Model Msg
main =
    Html.program
        { init = ( init, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \m -> Sub.none
        }
