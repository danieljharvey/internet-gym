module App.View.PageOne where

import App.Events (Event(..))
import App.PageOne.Events (PageOneEvent(..))
import App.PageOne.State (PageOneState)
import App.PageOne.Validation (validateState, PageOneError(..))
import App.State (State(..))
import App.View.Validations (makeValidDiv)
import Data.Either (Either(..), isLeft)
import Data.Foldable (for_)
import Data.List (List(Nil, Cons))
import Prelude (($), discard, show, (<<<), map)
import Pux.DOM.Events (onSubmit, onChange)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input, label, div, ul, li)
import Text.Smolder.HTML.Attributes (className, name, type', value, disabled)
import Text.Smolder.Markup ((!), (#!), text)


showBool :: Boolean -> String
showBool x = case x of
  true  -> "1"
  false -> "0"

showValidation :: Either (List PageOneError) PageOneState -> List String
showValidation valid = case valid of
  Right _      -> Cons "Great stuff!" $ Nil
  (Left error) -> map show error

getDisabled :: PageOneState -> String
getDisabled pageOne = case (isLeft (validateState pageOne)) of 
  true  -> "disabled"
  false -> ""

view :: State -> HTML Event
view (State st) =
  form ! name "signin" ! className "pageOne" #! onSubmit (PageOne <<< SignIn) $ do
    makeValidDiv (BadFirstName "") validated $ do
      label do text "First name"
      input ! type' "text" ! value st.pageOne.firstName #! onChange (PageOne <<< ChangeFirstName)
    div ! className "formSection" $ do
      label do text "Middle name"
      input ! type' "text" ! value st.pageOne.middleName #! onChange (PageOne <<< ChangeMiddleName)
    makeValidDiv (BadLastName "") validated $ do
      label do text "Last name"
      input ! type' "text" ! value st.pageOne.lastName #! onChange (PageOne <<< ChangeLastName)
    makeValidDiv TooYoung validated $ do
      label do text "Age"
      input ! type' "text" ! value (show st.pageOne.age) #! onChange (PageOne <<< ChangeAge)
    makeValidDiv NoDogs validated $ do
      label do text "Dogs: pretty OK?"
      input ! name "likesDogs" ! type' "checkbox"  #! onChange (PageOne <<< ChangeLikesDogs)
    div ! className "validation" $ do
      ul do for_ (showValidation $ validated) \str -> li $ text str
    div ! className "formSection" $ do
      button ! type' "submit" ! disabled (getDisabled st.pageOne) $ text "Sign In"
    where validated = validateState st.pageOne

