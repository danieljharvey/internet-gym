module App.Dog where

import App.Types.Event (Event)
import App.Types.State (State(..))
import Prelude (($))
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div, h1, ul, li)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup (text, (!))
import Data.Foldable (for_)

view :: State -> HTML Event
view (State s) =
  div ! className "dog" $ do
    h1 $ text "dogs"
    -- for_ (s.dogs.dogs) (\str -> h1 $ text str.message)

