module App.PageTwo.Validation where

import App.Utils.Validation (combineValidators, validator)
import App.State (PageTwoState)
import Data.Either (Either)
import Data.List (List, elem)
import Data.Show (class Show)
import Prelude ((==), compare, Ordering(GT), (<>), ($), not, const)

data PageTwoError = NoDogs | TooYoung | BadFirstName String | BadLastName String

instance showPageTwoError :: Show PageTwoError where
  show NoDogs              = "No dog love please, this is a place of hygiene."
  show TooYoung            = "Absolutely too young for this damn gym."
  show (BadFirstName name) = "I'm afraid we don't allow " <> name <> "s in here."
  show (BadLastName name)  = "I'm afraid we don't like the " <> name <> " family around here."

validateState :: PageTwoState -> Either (List PageTwoError) PageTwoState
validateState state = combineValidators [isLikesDogs, isOverTen, badFirstName, badLastName] state

isLikesDogs :: PageTwoState -> Either (List PageTwoError) PageTwoState
isLikesDogs = validator (\s -> s.likesDogs == false) (const NoDogs)

isOverTen :: PageTwoState -> Either (List PageTwoError) PageTwoState
isOverTen = validator (\s -> (compare s.age 10) == GT) (const TooYoung)

badFirstName :: PageTwoState -> Either (List PageTwoError) PageTwoState
badFirstName = validator (\s -> not $ elem s.firstName badFirstNames) (\s -> BadFirstName s.firstName)

badLastName :: PageTwoState -> Either (List PageTwoError) PageTwoState
badLastName = validator (\s -> not $ elem s.lastName badLastNames) (\s -> BadLastName s.lastName)

badFirstNames :: Array String
badFirstNames = ["Bruce", "Steve", "Horse", "Brad"]

badLastNames :: Array String
badLastNames = ["Smith", "Jones", "Cleese", "Sleaze"]