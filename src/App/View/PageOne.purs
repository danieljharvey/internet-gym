module App.View.PageOne where

import Prelude (($), discard, show)
import App.Events (Event(..))
import App.PageOne.Events (PageOneEvent(..))
import App.State (State(..))
import Pux.DOM.Events (onSubmit, onChange)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input, label, div)
import Text.Smolder.HTML.Attributes (className, name, type', value)
import Text.Smolder.Markup ((!), (#!), text)

view :: State -> HTML Event
view (State st) =
  form ! name "signin" ! className "pageOne" #! onSubmit (\ev -> PageOne (SignIn ev)) $ do
    div ! className "formSection" $ do
      label do text "Name"
      input ! type' "text" ! value st.pageOne.name #! onChange (\ev -> PageOne (ChangeName ev))
    div ! className "formSection" $ do
      label do text "Age"
      input ! type' "text" ! value (show st.pageOne.age) #! onChange (\ev -> PageOne (ChangeAge ev))
    div ! className "formSection" $ do
      button ! type' "submit" $ text "Sign In"

