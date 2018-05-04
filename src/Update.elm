module Update exposing (update)

import Validation exposing (Event(..))
import Types exposing (Msg(..))
import Model exposing (Model, calculateConsumption, validateModel, validateDistance, validateFueled)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputDistance d ->
            ( model |> validateDistance (OnChange d)
            , Cmd.none
            )

        BlurDistance ->
            ( model |> validateDistance OnBlur
            , Cmd.none
            )

        InputFueled f ->
            ( model |> validateFueled (OnChange f)
            , Cmd.none
            )

        BlurFueled ->
            ( model |> validateFueled OnBlur
            , Cmd.none
            )

        Submit ->
            ( model |> validateModel |> calculateConsumption, Cmd.none )
