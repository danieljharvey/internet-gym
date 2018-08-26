module Main where

import App.Events (foldp)
import App.Routes (match)
import App.State (init)
import App.Types.Event (Event(..))
import App.Types.State (State)
import App.View.Layout (view)
import Control.Applicative (pure)
import Control.Bind ((=<<), bind, discard)
import Effect (Effect)
import Pux (App, start)
import Pux.DOM.Events (DOMEvent)
import Pux.DOM.History (sampleURL)
import Pux.Renderer.React (renderToDOM)
import Signal ((~>))
import Web.HTML (window)

type WebApp
  = App (DOMEvent -> Event) Event State

main :: String -> State -> Effect WebApp
main url state = do
  urlSignal <- sampleURL =<< window
  -- | Map a signal of URL changes to PageView actions.
  let routeSignal = urlSignal ~> \r ->
        PageView (match r)
  let fetchEffect = urlSignal ~> \r ->
        RequestDogs
  let inputs = [ routeSignal
               , fetchEffect
               ]
  app <- start { initialState: state, view, foldp, inputs }
  renderToDOM "#app" app.markup app.input
  pure app

initialState :: State
initialState = init "/"
