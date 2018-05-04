module Model exposing (Model, init, calculateConsumption)

import Validation exposing (Field, Validity(..), field, validity, (|:))


type alias Model =
    { distance : Field String Float
    , fueled : Field String Float
    , consumption : Maybe Float
    }


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
