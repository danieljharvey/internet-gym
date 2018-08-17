module App.Events where

import App.PageOne.Events (PageOneEvent)
import App.PageOne.Reducer as P1Reducer
import App.Routes (Route, match)
import App.State (State(..))
import Effect.Aff (attempt)
import Control.Applicative (pure)
import Control.Bind ((=<<), bind)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.Either (Either(Left, Right), either)
import Network.HTTP.Affjax (get)
import Prelude (discard, (<>), show)
import Effect.Class (liftEffect)
import Web.Event.Event (preventDefault)
import Web.HTML (window)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState)
import Web.HTML.Window (history)
import Foreign (unsafeToForeign)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Prelude (discard)
import Pux (EffModel, noEffects, onlyEffects)
import Pux.DOM.Events (DOMEvent)
import App.Dog
import Data.Function (($), (<<<), const)

data Event
  = PageView Route
  | Navigate String DOMEvent
  | PageOne (PageOneEvent)
  | RequestDogs
  | ReceiveDogs (Either String Dog)
  
foldp :: Event -> State -> EffModel State Event
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }
foldp (Navigate url ev) (State st) = onlyEffects (State st) [
    liftEffect do
      preventDefault ev
      h <- history =<< window
      pushState (unsafeToForeign {}) (DocumentTitle "") (URL url) h
      pure $ Just $ PageView (match url)
]
foldp (PageOne ev) (State st) = noEffects $ State st { pageOne = (P1Reducer.foldp ev st.pageOne) }

foldp (ReceiveDogs (Left err)) (State st) =
  noEffects $ State st { dogs = {status : "Error fetching todos: " <> show err, dogs: [] } }
foldp (ReceiveDogs (Right dogs)) (State st) =
  noEffects $ State st { dogs = { dogs: [dogs], status: "Todos" } }
foldp (RequestDogs) (State st) =
  { state: State st { dogs = { dogs: [], status: "Fetching todos..." } }
  , effects: [ do
      res <- attempt $ get "https://dog.ceo/api/breeds/image/random"
      let decode r = decodeJson r.response :: Either String Dog
      let dogs = either (Left <<< show) decode res
      pure $ Just $ ReceiveDogs dogs
    ]
  }