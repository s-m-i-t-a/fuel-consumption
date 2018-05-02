module Model exposing (Model, init)

import Validation exposing (Field, field)


type alias Model =
    { distance : Field String Float
    , fueled : Field String Float
    }


init : Model
init =
    { distance = field ""
    , fueled = field ""
    }
