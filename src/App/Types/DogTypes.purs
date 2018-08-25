module App.Types.Dog where

import Prelude (class Show, bind, pure, ($), (<>))

import Data.Argonaut (class DecodeJson, decodeJson, (.?))

-- | Because AJAX is effectful and asynchronous, we represent requests and
-- | responses as input events.

type DogState =
  { dogs :: Dogs
  , status :: String }

type Dogs = Array Dog

newtype Dog = Dog
  { status :: String
  , message :: String }

instance showDog :: Show Dog where
  show :: Dog -> String
  show (Dog d) = "DOG: " <> d.message

-- | Decode our Todo JSON we receive from the server
instance decodeJsonDog :: DecodeJson Dog where
  decodeJson json = do
    obj <- decodeJson json
    status <- obj .? "status"
    message <- obj .? "message"
    pure $ Dog { status: status, message: message }
