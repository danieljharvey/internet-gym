module App.PageOne.Validation where

import App.Utils.Validation (combineValidators, validator)
import App.Types.State (PageOneState)
import Data.Either (Either)
import Data.List (List, elem)
import Data.Show (class Show)
import Prelude ((==), compare, Ordering(GT), (<>), ($), not, const)

data PageOneError = NoDogs | TooYoung | BadFirstName String | BadLastName String

instance showPageOneError :: Show PageOneError where
  show NoDogs              = "No dog love please, this is a place of hygiene."
  show TooYoung            = "Absolutely too young for this damn gym."
  show (BadFirstName name) = "I'm afraid we don't allow " <> name <> "s in here."
  show (BadLastName name)  = "I'm afraid we don't like the " <> name <> " family around here."

validateState :: PageOneState -> Either (List PageOneError) PageOneState
validateState state = combineValidators [isLikesDogs, isOverTen, badFirstName, badLastName] state

isLikesDogs :: PageOneState -> Either (List PageOneError) PageOneState
isLikesDogs = validator (\s -> s.likesDogs == false) (const NoDogs)

isOverTen :: PageOneState -> Either (List PageOneError) PageOneState
isOverTen = validator (\s -> (compare s.age 10) == GT) (const TooYoung)

badFirstName :: PageOneState -> Either (List PageOneError) PageOneState
badFirstName = validator (\s -> not $ elem s.firstName badFirstNames) (\s -> BadFirstName s.firstName)

badLastName :: PageOneState -> Either (List PageOneError) PageOneState
badLastName = validator (\s -> not $ elem s.lastName badLastNames) (\s -> BadLastName s.lastName)

badFirstNames :: Array String
badFirstNames = ["Bruce", "Steve", "Horse", "Brad"]

badLastNames :: Array String
badLastNames = ["Smith", "Jones", "Cleese", "Sleaze"]