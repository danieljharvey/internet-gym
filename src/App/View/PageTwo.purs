module App.View.PageTwo where

import App.Events (Event(..))
import App.PageTwo.Events (PageTwoEvent(..))
import App.State (State(..))
import App.PageTwo.State (PageTwoState)
import App.PageTwo.Validation (validateState, PageTwoError)
import Prelude (($), discard, show, (<<<), map)
import Data.Either (Either(..), isLeft)
import Data.Foldable (for_)
import Data.List (List(Nil, Cons))
import Pux.DOM.Events (onSubmit, onChange)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input, label, div, ul, li)
import Text.Smolder.HTML.Attributes (className, name, type', value, disabled)
import Text.Smolder.Markup ((!), (#!), text)

showBool :: Boolean -> String
showBool x = case x of
  true  -> "1"
  false -> "0"

showValidation :: Either (List PageTwoError) PageTwoState -> List String
showValidation valid = case valid of
  Right _      -> Cons "Great stuff!" $ Nil
  (Left error) -> map show error

getDisabled :: PageTwoState -> String
getDisabled pageTwo = case (isLeft (validateState pageTwo)) of 
  true  -> "disabled"
  false -> ""

view :: State -> HTML Event
view (State st) =
  form ! name "signin" ! className "PageTwo" #! onSubmit (PageTwo <<< SignIn) $ do
    div ! className "formSection" $ do
      label do text "First line of address"
      input ! type' "text" ! value st.pageTwo.firstLine #! onChange (PageTwo <<< ChangeFirstName)
    div ! className "formSection" $ do
      label do text "Second line of address"
      input ! type' "text" ! value st.pageTwo.secondLine #! onChange (PageTwo <<< ChangeFirstName)
    div ! className "formSection" $ do
      label do text "City"
      input ! type' "text" ! value st.pageTwo.city #! onChange (PageTwo <<< ChangeFirstName)
    div ! className "formSection" $ do
      label do text "Postcode"
      input ! type' "text" ! value st.pageTwo.postCode #! onChange (PageTwo <<< ChangeFirstName)
    div ! className "formSection" $ do
      label do text "Phone number"
      input ! type' "text" ! value st.pageTwo.phoneNumber #! onChange (PageTwo <<< ChangeFirstName)
    div ! className "validation" $ do
      ul do for_ (showValidation $ validateState st.pageTwo) \str -> li $ text str
    div ! className "formSection" $ do
      button ! type' "submit" ! disabled (getDisabled st.pageTwo) $ text "Sign In"

