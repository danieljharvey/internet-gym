module App.Dog where

import Data.Foldable

import App.Types.Dog (Dog(..))
import App.Types.Event (Event)
import App.Types.State (State(..))
import Prelude (($))
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div, img, ul)
import Text.Smolder.HTML.Attributes (className, src)
import Text.Smolder.Markup ((!))

view :: State -> HTML Event
view (State st) = div ! className "dog" $ do
  ul do
    for_ (st.dogs.dogs) (\(Dog dog) ->
      img ! src dog.message)
