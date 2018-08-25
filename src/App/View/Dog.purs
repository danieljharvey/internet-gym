module App.Dog where

import App.Types.Event (Event)
import App.Types.State (State(..))
import Prelude (($))
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (div, h1)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup (text, (!))


-- | Because AJAX is effectful and asynchronous, we represent requests and
-- | responses as input events.


view :: State -> HTML Event
view (State s) =
  div ! className "dog" $ do
    h1 $ text "dogs"
    
    --ul $ do
    --  for_ (s.dogs.dogs) \str -> li $ text str.message

