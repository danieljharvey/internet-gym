module App.PageTwo.Validation where

import App.Utils.Validation (combineValidators)
import App.PageTwo.State (PageTwoState)
import Data.Either (Either)
import Data.List (List)
import Data.Show (class Show)
import Prelude ((<>))

data PageTwoError = NoDogs | TooYoung | BadFirstName String | BadLastName String

instance showPageTwoError :: Show PageTwoError where
  show NoDogs              = "No dog love please, this is a place of hygiene."
  show TooYoung            = "Absolutely too young for this damn gym."
  show (BadFirstName name) = "I'm afraid we don't allow " <> name <> "s in here."
  show (BadLastName name)  = "I'm afraid we don't like the " <> name <> " family around here."

validateState :: PageTwoState -> Either (List PageTwoError) PageTwoState
validateState state = combineValidators [] state

