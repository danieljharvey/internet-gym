module App.Dog where

import Control.Applicative (pure)
import Control.Bind (bind)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import Data.Function (($))

-- | Because AJAX is effectful and asynchronous, we represent requests and
-- | responses as input events.

type DogState =
  { dogs :: Dogs
  , status :: String }

type Dogs = Array Dog

newtype Dog = Dog
  { status :: String
  , message :: String }

initialDogState :: DogState
initialDogState = { dogs: [], status: "Nothing loaded from server yet" }

-- | Decode our Todo JSON we receive from the server
instance decodeJsonDog :: DecodeJson Dog where
  decodeJson json = do
    obj <- decodeJson json
    status <- obj .? "status"
    message <- obj .? "message"
    pure $ Dog { status: status, message: message }

