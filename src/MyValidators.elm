module MyValidators exposing (distanceValidator, fueledValidator)

import Validation exposing (Validator)
import Validation exposing ((>&&))
import Validators exposing (isPositiveFloat, isNotEmpty)


distanceValidator : Validator String Float
distanceValidator =
    isNotEmpty "A distance is required"
        >&& isPositiveFloat "Distance must be positive float value."


fueledValidator : Validator String Float
fueledValidator =
    isNotEmpty "A fueled is required"
        >&& isPositiveFloat "Fueled must be positive float value."
