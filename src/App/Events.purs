module App.Events where

import App.PageOne.Events (PageOneEvent)
import App.PageOne.Reducer as P1Reducer
import App.Routes (Route, match)
import App.State (State(..))
import Control.Monad.Aff (attempt)
import Control.Applicative (pure)
import Control.Bind ((=<<), bind)
import Control.Monad.Eff.Class (liftEff)
import Data.Argonaut (class DecodeJson, decodeJson, (.?))
import DOM (DOM)
import DOM.Event.Event (preventDefault)
import DOM.HTML (window)
import DOM.HTML.History (DocumentTitle(..), URL(..), pushState)
import DOM.HTML.Types (HISTORY)
import DOM.HTML.Window (history)
import Data.Foreign (toForeign)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Data.Either (Either(Left, Right), either)
import Network.HTTP.Affjax (AJAX, get)
import Prelude (discard, (<>), show)
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
  
type AppEffects fx = (ajax :: AJAX, history :: HISTORY, dom :: DOM | fx)

foldp :: ∀ fx. Event -> State -> EffModel State Event (AppEffects fx)
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }
foldp (Navigate url ev) (State st) = onlyEffects (State st) [
    liftEff do
      preventDefault ev
      h <- history =<< window
      pushState (toForeign {}) (DocumentTitle "") (URL url) h
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