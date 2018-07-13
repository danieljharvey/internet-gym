module App.View.PageOne where

import App.Events (Event(..))
import App.PageOne.Events (PageOneEvent(..))
import App.State (State(..), PageOneState)
import App.PageOne.Validation (validateState)
import Prelude (($), discard, show, (<<<))
import Data.Either (Either(..))
import Pux.DOM.Events (onSubmit, onChange)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input, label, div, p)
import Text.Smolder.HTML.Attributes (className, name, type', value)
import Text.Smolder.Markup ((!), (#!), text)

showBool :: Boolean -> String
showBool x = case x of
  true  -> "1"
  false -> "0"

showValidation :: Either String PageOneState -> String
showValidation valid = case valid of
  Right _    -> "VALID"
  (Left str) -> str

view :: State -> HTML Event
view (State st) =
  form ! name "signin" ! className "pageOne" #! onSubmit (PageOne <<< SignIn) $ do
    div ! className "formSection" $ do
      label do text "Name"
      input ! type' "text" ! value st.pageOne.name #! onChange  (PageOne <<< ChangeName)
    div ! className "formSection" $ do
      label do text "Age"
      input ! type' "text" ! value (show st.pageOne.age) #! onChange  (PageOne <<< ChangeAge)
    div ! className "formSection" $ do
      label do text "Dogs: pretty OK?"
      input ! name "likesDogs" ! type' "checkbox"  #! onChange (PageOne <<< ChangeLikesDogs)
    div ! className "validation" $ do
      p do text (showValidation $ validateState st.pageOne)
    div ! className "formSection" $ do
      button ! type' "submit" $ text "Sign In"

