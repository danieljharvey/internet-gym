module App.Events where

import App.Routes (match)
import App.Types.Dog (Dog)
import App.Types.Event (Event(..))
import App.Types.State (State(..))
import Control.Applicative (pure)
import Control.Bind ((=<<), bind)
import Data.Argonaut (decodeJson)
import Data.Either (Either(Left, Right))
import Data.Function (($))
import Data.HTTP.Method (Method(..))
import Data.Maybe (Maybe(..))
import Effect.Class (liftEffect)
import Effect.Console (log)
import Foreign (unsafeToForeign)
import Prelude (discard, (<>), show)
import Pux (EffModel, noEffects, onlyEffects)
import Web.Event.Event (preventDefault)
import Web.HTML (window)
import Web.HTML.History (DocumentTitle(..), URL(..), pushState)
import Web.HTML.Window (history)

import App.PageOne.Reducer as P1Reducer
import App.PageTwo.Reducer as P2Reducer
import Data.Argonaut.Core as J
import Network.HTTP.Affjax as AX
import Network.HTTP.Affjax.Response as AXRes

apiPath :: String
apiPath = "https://dog.ceo/api/breeds/image/random"

foldp :: Event -> State -> EffModel State Event
foldp (PageView route) (State st) = noEffects $ State st { route = route, loaded = true }

foldp (Navigate url ev) (State st) = onlyEffects (State st) [ liftEffect do
                                                              preventDefault ev
                                                              h <- history =<< window
                                                              pushState (unsafeToForeign {}) (DocumentTitle "") (URL url) h
                                                              pure $ Just $ PageView (match url)
                                                            , liftEffect do
                                                              pure $ Just $ RequestDogs
                                                            ]

foldp (PageOne ev) (State st) = noEffects $ State st { pageOne = (P1Reducer.foldp ev st.pageOne) }

foldp (PageTwo ev) (State st) = noEffects $ State st { pageTwo = (P2Reducer.foldp ev st.pageTwo) }

foldp (ReceiveDogs (Left err)) (State st) = noEffects $ State st { dogs = { status: "Error fetching todos: " <> show err
                                                                          , dogs: []
                                                                          } }

foldp (ReceiveDogs (Right dogs)) (State st) = noEffects $ State st { dogs = { dogs: [ dogs
                                                                                    ]
                                                                            , status: "Todos"
                                                                            } }

foldp (RequestDogs) (State st) = { state: State st { dogs = { dogs: []
                                                            , status: "Fetching todos..."
                                                            } }
                                 , effects: [ do
                                              liftEffect $ log "Requesting Dogs"
                                              res <- AX.affjax AXRes.json (AX.defaultRequest { url = apiPath, method = Left GET })
                                              liftEffect $ log $ "GET /api response: " <> J.stringify res.response
                                              let decode r = decodeJson r.response :: Either String Dog
                                              pure $ Just $ ReceiveDogs $ decode res
                                            ]
                                 }
