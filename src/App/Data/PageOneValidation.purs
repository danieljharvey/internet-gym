module App.PageOne.Validation where

import App.State (PageOneState)
import Data.Either (Either(..))
import Data.List (List(..), elem)
import Prelude ((==), compare, Ordering(GT), (=<<), (<>), ($), not)

validateState :: PageOneState -> Either String PageOneState
validateState state = isLikesDogs =<< isOverTen =<< badFirstName =<< badLastName state

validator :: forall a. (a -> Boolean) -> (a -> String) -> a -> Either String a
validator predicate message state = case (predicate state) of
    true  -> Right state
    false -> Left $ message state

isLikesDogs :: PageOneState -> Either String PageOneState
isLikesDogs = validator (\s -> s.likesDogs == false) (\s -> "No dog love please, this is a place of hygiene")

isOverTen :: PageOneState -> Either String PageOneState
isOverTen = validator (\s -> (compare s.age 10) == GT) (\s -> "Absolutely too young for this damn gym")

badFirstName :: PageOneState -> Either String PageOneState
badFirstName = validator (\s -> not $ elem s.firstName badFirstNames) (\s -> "I'm afraid we don't allow " <> s.firstName <> "s in here.")

badLastName :: PageOneState -> Either String PageOneState
badLastName = validator (\s -> not $ elem s.lastName badLastNames) (\s -> "I'm afraid we don't like the " <> s.lastName <> " family around here.")

badFirstNames :: List String
badFirstNames = Cons "Bruce" $ Cons "Steve" $ Cons "Horse" $ Cons "Brad" $ Nil

badLastNames :: List String
badLastNames = Cons "Smith" $ Cons "Jones" $ Cons "Cleese" $ Cons "Sleaze" $ Nil