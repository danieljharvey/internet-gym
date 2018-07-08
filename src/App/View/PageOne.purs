module App.View.PageOne where

import Prelude
import App.PageOne.Events (PageOneEvent(..))
import App.Events (Event(..))
import App.State (State(..))
import Pux.DOM.Events (onSubmit, onChange)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input)
import Text.Smolder.HTML.Attributes (name, type', value)
import Text.Smolder.Markup ((!), (#!), text)

view :: State -> HTML Event
view (State st) =
  form ! name "signin" #! onSubmit (\ev -> PageOne (SignIn ev)) $ do
    input ! type' "text" ! value st.pageOne.name #! onChange (\ev -> PageOne (ChangeName ev))
    input ! type' "text" ! value (show st.pageOne.age) #! onChange (\ev -> PageOne (ChangeAge ev))
    button ! type' "submit" $ text "Sign In"

