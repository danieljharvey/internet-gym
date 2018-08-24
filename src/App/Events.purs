module App.Events where

import App.Dog (Dog)

import App.PageOne.Events (PageOneEvent)
import App.PageOne.Reducer as P1Reducer
import App.Routes (Route, match)
import App.State (State(..))

import Control.Applicative (pure)
import Control.Bind ((=<<), bind)
import Data.Either (Either(..))
import Data.Function (($))
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Foreign (unsafeToForeign)
import Prelude (discard, (<>), show)
import Pux (EffModel, noEffects, onlyEffects)
import Pux.DOM.Events (DOMEvent)
import Web.Event.Event (preventDefault)
import Web.HTML (window)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState)
import Web.HTML.Window (history)


import Data.Argonaut.Core as J

import Data.HTTP.Method (Method(..))
import Effect.Console (log)
import Network.HTTP.Affjax as AX
import Network.HTTP.Affjax.Response as AXRes

data Event
  = PageView Route
  | Navigate String DOMEvent
  | PageOne (PageOneEvent)
  | RequestDogs
  | ReceiveDogs (Either String Dog)
  
apiPath :: String
apiPath = "https://dog.ceo/api/breeds/image/random"


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
      res <- AX.affjax AXRes.json (AX.defaultRequest { url = "/api", method = Left GET })
      liftEffect $ log $ "GET /api response: " <> J.stringify res.response
      pure Nothing
    ]
  }

  -- let decode r = decodeJson r.response :: Either String Dog
      -- let dogs = either (Left <<< show) decode res
      -- pure $ Just $ ReceiveDogs dogs