module App.PageTwo.Validation where

import App.Utils.Validation (combineValidators, validator)
import App.PageTwo.State (PageTwoState)
import Data.Either (Either)
import Data.List (List)
import Data.Show (class Show)
import Prelude ((==), const, ($), not)

data PageTwoError = FirstLineEmpty
                  | SecondLineEmpty
                  | CityEmpty
                  | PostCodeEmpty
                  | PhoneNumberEmpty 

type PageTwoValidator = PageTwoState -> Either (List PageTwoError) PageTwoState

instance showPageTwoError :: Show PageTwoError where
  show FirstLineEmpty   = "First line of address is empty"
  show SecondLineEmpty  = "Second line of address is empty"
  show CityEmpty        = "City is empty"
  show PostCodeEmpty    = "Post code is empty"
  show PhoneNumberEmpty = "Phone number is empty"

validateState :: PageTwoValidator
validateState state = combineValidators [isFirstLineEmpty, isSecondLineEmpty, isCityEmpty, isPostCodeEmpty, isPhoneNumberEmpty] state

isFirstLineEmpty :: PageTwoValidator
isFirstLineEmpty = validator (\s -> not $ s.firstLine == "") (const FirstLineEmpty)

isSecondLineEmpty :: PageTwoValidator
isSecondLineEmpty = validator (\s -> not $ s.secondLine == "") (const SecondLineEmpty)

isCityEmpty :: PageTwoValidator
isCityEmpty = validator (\s -> not $ s.city == "") (const CityEmpty)

isPostCodeEmpty :: PageTwoValidator
isPostCodeEmpty = validator (\s -> not $ s.postCode == "") (const PostCodeEmpty)

isPhoneNumberEmpty :: PageTwoValidator
isPhoneNumberEmpty = validator (\s -> not $ s.phoneNumber == "") (const PhoneNumberEmpty)
