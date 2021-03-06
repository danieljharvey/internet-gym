module App.View.Homepage where

import App.Types.Event (Event(..))
import App.Types.State (State)
import Control.Bind (discard)
import Data.Function (($))
import Pux.DOM.Events (onClick)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (a, div, h1)
import Text.Smolder.HTML.Attributes (href, className)
import Text.Smolder.Markup ((!), (#!), text)

view :: State -> HTML Event
view s = div ! className "homePage" $ do
  h1 $ text "Internet Gym"
  a ! className "pageOne" ! href "/" #! onClick (Navigate "/page/1") $ text "Page 1"
  a ! className "github" ! href "/" #! onClick (Navigate "/page/2") $ text "Page 2"
  a ! className "guide" #! onClick (Navigate "/dogs") $ text "Dogs"
