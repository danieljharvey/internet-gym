module App.View.PageOne where

import Prelude (bind)
import App.Events (Event)
import App.State (State)
import Data.Function (($))
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div, h1, p)
import Text.Smolder.Markup (text)

view :: State -> HTML Event
view s =
  div do
    _ <- h1 $ text "Page One"
    p $ text "horse"
