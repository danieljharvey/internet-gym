module App.Events where

import App.PageOne.Events (PageOneEvent)
import App.PageOne.Reducer as P1Reducer
import App.Routes (Route, match)
import App.State (State(..))
import Control.Applicative (pure)
import Control.Bind ((=<<), bind)
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

data Event
  = PageView Route
  | Navigate String DOMEvent
  | PageOne (PageOneEvent)
  
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
