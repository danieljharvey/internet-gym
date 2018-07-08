module App.Events where

import App.PageOne.Events (PageOneEvent)
import App.PageOne.Reducer as P1Reducer
import App.Routes (Route, match)
import App.State (State(..))
import Control.Applicative (pure)
import Control.Bind ((=<<), bind)
import Control.Monad.Eff.Class (liftEff)
import DOM (DOM)
import DOM.Event.Event (preventDefault)
import DOM.HTML (window)
import DOM.HTML.History (DocumentTitle(..), URL(..), pushState)
import DOM.HTML.Types (HISTORY)
import DOM.HTML.Window (history)
import Data.Foreign (toForeign)
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Network.HTTP.Affjax (AJAX)
import Prelude (discard)
import Pux (EffModel, noEffects, onlyEffects)
import Pux.DOM.Events (DOMEvent)

data Event
  = PageView Route
  | Navigate String DOMEvent
  | PageOne (PageOneEvent)
  
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
foldp (PageOne ev) state = noEffects $ newState where
  newState = P1Reducer.foldp ev state

foldp _ (State st) = noEffects $ State st