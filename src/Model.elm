module Model exposing (Model, init, calculateConsumption, validateModel, validateDistance, validateFueled)

import Validation exposing (Field, Event(..), Validity(..), field, validate, validity, (|:))
import MyValidators exposing (distanceValidator, fueledValidator)


type alias Model =
    { distance : Field String Float
    , fueled : Field String Float
    , consumption : Maybe Float
    }


type alias DistanceModel m =
    { m | distance : Field String Float }


type alias FueledModel m =
    { m | fueled : Field String Float }


init : Model
init =
    { distance = field ""
    , fueled = field ""
    , consumption = Nothing
    }


calculate : Float -> Float -> Float
calculate distance fueled =
    (fueled * 100) / distance


calculateConsumption : Model -> Model
calculateConsumption ({ distance, fueled } as model) =
    let
        result =
            Valid calculate
                |: validity distance
                |: validity fueled
    in
        case result of
            Valid val ->
                { model | consumption = Just val }

            _ ->
                { model | consumption = Nothing }


validateDistance : Event String -> DistanceModel m -> DistanceModel m
validateDistance event model =
    { model | distance = validate event distanceValidator model.distance }


validateFueled : Event String -> FueledModel m -> FueledModel m
validateFueled event model =
    { model | fueled = validate event fueledValidator model.fueled }


validateModel : Model -> Model
validateModel model =
    let
        distance =
            validate OnSubmit distanceValidator model.distance

        fueled =
            validate OnSubmit fueledValidator model.fueled
    in
        { model | distance = distance, fueled = fueled }
