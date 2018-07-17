module App.Dog where

import Prelude (discard)
import Control.Applicative (pure)
import Control.Bind (bind)
import Control.Monad.Aff (attempt)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import Data.Either (Either(Left, Right), either)
import Data.Foldable (for_)
import Data.Function (($), (<<<), const)
import Data.Maybe (Maybe(..))
import Data.Semigroup ((<>))
import Data.Show (show)
import Network.HTTP.Affjax (AJAX, get)
import Pux (EffModel, noEffects)
import Pux.DOM.Events (onClick)
import Pux.DOM.HTML (HTML)
import Pux.DOM.HTML.Attributes (key)
import Text.Smolder.HTML (button, div, h1, li, ol)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup ((!), (#!), text)

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

