module App.Events where

import Prelude (discard)
import Control.Applicative (pure)
import App.Routes (Route, match)
import App.State (State(..))
import Control.Bind ((=<<), bind)
import Control.Monad.Eff.Class (liftEff)
import Data.Function (($))
import Data.Foreign (toForeign)
import Data.Maybe (Maybe(..))
import DOM (DOM)
import DOM.Event.Event (preventDefault)
import DOM.HTML (window)
import DOM.HTML.History (DocumentTitle(..), URL(..), pushState)
import DOM.HTML.Window (history)
import DOM.HTML.Types (HISTORY)
import Network.HTTP.Affjax (AJAX)
import Pux (EffModel, noEffects, onlyEffects)
import Pux.DOM.Events (DOMEvent, targetValue)

data Event
  = PageView Route
  | Navigate String DOMEvent
  | SignIn DOMEvent
  | UsernameChange DOMEvent
  | PasswordChange DOMEvent

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
foldp (UsernameChange ev) (State st) =  { state: State st { pageOne = { name : (targetValue ev), age: 0 } }, effects: [] }
foldp _ (State st) = noEffects $ State st