module App.View.PageTwo where

import App.Events (Event(..))
import App.PageTwo.Events (PageTwoEvent(..))
import App.State (State(..), PageTwoState)
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
      label do text "First name"
      input ! type' "text" ! value st.pageTwo.firstName #! onChange (PageTwo <<< ChangeFirstName)
    div ! className "formSection" $ do
      label do text "Middle name"
      input ! type' "text" ! value st.pageTwo.middleName #! onChange (PageTwo <<< ChangeMiddleName)
    div ! className "formSection" $ do
      label do text "Last name"
      input ! type' "text" ! value st.pageTwo.lastName #! onChange (PageTwo <<< ChangeLastName)
    div ! className "formSection" $ do
      label do text "Age"
      input ! type' "text" ! value (show st.pageTwo.age) #! onChange (PageTwo <<< ChangeAge)
    div ! className "formSection" $ do
      label do text "Dogs: pretty OK?"
      input ! name "likesDogs" ! type' "checkbox"  #! onChange (PageTwo <<< ChangeLikesDogs)
    div ! className "validation" $ do
      ul do for_ (showValidation $ validateState st.pageTwo) \str -> li $ text str
    div ! className "formSection" $ do
      button ! type' "submit" ! disabled (getDisabled st.pageTwo) $ text "Sign In"

