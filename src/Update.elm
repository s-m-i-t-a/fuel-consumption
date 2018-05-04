module Update exposing (update)

import Validation exposing (validate, Event(..))
import Types exposing (Msg(..))
import Model exposing (Model, calculateConsumption)
import MyValidators exposing (distanceValidator, fueledValidator)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputDistance d ->
            ( { model | distance = validate (OnChange d) distanceValidator model.distance }
                |> calculateConsumption
            , Cmd.none
            )

        BlurDistance ->
            ( { model | distance = validate OnBlur distanceValidator model.distance }
                |> calculateConsumption
            , Cmd.none
            )

        InputFueled f ->
            ( { model | fueled = validate (OnChange f) fueledValidator model.fueled }
                |> calculateConsumption
            , Cmd.none
            )

        BlurFueled ->
            ( { model | fueled = validate OnBlur fueledValidator model.fueled }
                |> calculateConsumption
            , Cmd.none
            )
