module App.View.PageTwo where

import App.Events (Event(..))
import App.PageTwo.Events (PageTwoEvent(..))
import App.PageTwo.State (PageTwoState)
import App.PageTwo.Validation (PageTwoError(..), PageTwoValidation, validateState)
import App.State (State(..))
import App.View.Validations (makeValidDiv)
import Data.Either (Either(..), isLeft)
import Data.Foldable (for_)
import Data.List (List(Nil, Cons))
import Prelude (($), discard, show, (<<<), map)
import Pux.DOM.Events (onSubmit, onChange)
import Pux.DOM.HTML (HTML)
import Text.Smolder.HTML (button, form, input, label, div, ul, li, option, select)
import Text.Smolder.HTML.Attributes (className, name, type', value, disabled)
import Text.Smolder.Markup ((!), (#!), text)


showBool :: Boolean -> String
showBool x = case x of
  true  -> "1"
  false -> "0"

showValidation :: PageTwoValidation -> List String
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
    makeValidDiv FirstLineEmpty validated $ do
      label do text "First line of address"
      input ! type' "text" ! value st.pageTwo.firstLine #! onChange (PageTwo <<< ChangeFirstLine)
    makeValidDiv SecondLineEmpty validated $ do
      label do text "Second line of address"
      input ! type' "text" ! value st.pageTwo.secondLine #! onChange (PageTwo <<< ChangeSecondLine)
    makeValidDiv CityEmpty validated $ do
      label do text "City"
      input ! type' "text" ! value st.pageTwo.city #! onChange (PageTwo <<< ChangeCity)
    makeValidDiv PostCodeEmpty validated $ do
      label do text "Postcode"
      input ! type' "text" ! value st.pageTwo.postCode #! onChange (PageTwo <<< ChangePostCode)
    makeValidDiv PhoneNumberEmpty validated $ do
      label do text "Phone number"
      input ! type' "text" ! value st.pageTwo.phoneNumber #! onChange (PageTwo <<< ChangePhoneNumber)
    div ! className "formSection" $ do
      label do text "Pre-existing medical conditions"
      select ! name "medical" $ do
         option ! value "horse" $ do text "Horses"
         option ! value "dog" $ do text "Dogses"
    div ! className "validation" $ do
      ul do for_ (showValidation validated) \str -> li $ text str
    div ! className "formSection" $ do
      button ! type' "submit" ! disabled (getDisabled st.pageTwo) $ text "Sign In"
  where validated = validateState st.pageTwo

