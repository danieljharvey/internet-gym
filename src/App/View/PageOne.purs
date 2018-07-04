module App.View.PageOne where

import Prelude (bind, discard)
import App.Events (Event(..))
import App.State (State(..))
import Data.Function (($))
import Pux.DOM.HTML (HTML)
import React.DOM.Props (onChange)
import Text.Smolder.HTML (form, div, h1, p, input)
import Text.Smolder.Markup ((!), text, (#!))
import Text.Smolder.HTML.Attributes (name, type', value)

view :: State -> HTML Event
view (State st) =
  div do
    _ <- h1 $ text "Page One"
    p $ text "Don't forget to fill in every single part"
    form ! name "page-one" $ do
      input ! type' "text" ! value st.pageOne.name #! onChange SetName
