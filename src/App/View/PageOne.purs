module App.View.PageOne where

import Prelude
import App.Events (Event(..))
import App.State (State(..))
import Control.Monad.Eff.Class (liftEff)
import Data.Maybe (Maybe(..))
import DOM (DOM)
import DOM.Event.Event (preventDefault)
import Pux (EffModel, noEffects)
import Pux.DOM.Events (DOMEvent, onSubmit, onChange, targetValue)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input)
import Text.Smolder.HTML.Attributes (name, type', value)
import Text.Smolder.Markup ((!), (#!), text)

view :: State -> HTML Event
view (State st) =
  form ! name "signin" #! onSubmit SignIn $ do
    input ! type' "text" ! value st.pageOne.name #! onChange UsernameChange
    input ! type' "password" ! value st.pageOne.name #! onChange PasswordChange
    button ! type' "submit" $ text "Sign In"

