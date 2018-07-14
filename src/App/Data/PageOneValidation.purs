module App.PageOne.Validation where

import App.State (PageOneState)
import Data.Either (Either(..))
import Data.List (List(..), elem)
import Data.Monoid (mempty)
import Prelude ((==), compare, Ordering(GT), (<>), ($), not)

validateState :: PageOneState -> Either (List String) PageOneState
validateState state = isLikesDogs state `combineEithers` isOverTen state `combineEithers` badFirstName state `combineEithers` badLastName state

combineEithers :: Either (List String) PageOneState -> Either (List String) PageOneState -> Either (List String) PageOneState
combineEithers (Left str) (Left str2)  = Left $ str  <> str2
combineEithers (Left str) (Right _)    = Left $ str  <> mempty
combineEithers (Right _) (Left str2)   = Left $ str2 <> mempty
combineEithers (Right st) (Right st2)  = Right st

validator :: forall a. (a -> Boolean) -> (a -> String) -> a -> Either (List String) a
validator predicate message state = case (predicate state) of
    true  -> Right state
    false -> Left $ Cons (message state) $ Nil

isLikesDogs :: PageOneState -> Either (List String) PageOneState
isLikesDogs = validator (\s -> s.likesDogs == false) (\s -> "No dog love please, this is a place of hygiene.")

isOverTen :: PageOneState -> Either (List String) PageOneState
isOverTen = validator (\s -> (compare s.age 10) == GT) (\_ -> "Absolutely too young for this damn gym.")

badFirstName :: PageOneState -> Either (List String) PageOneState
badFirstName = validator (\s -> not $ elem s.firstName badFirstNames) (\s -> "I'm afraid we don't allow " <> s.firstName <> "s in here.")

badLastName :: PageOneState -> Either (List String) PageOneState
badLastName = validator (\s -> not $ elem s.lastName badLastNames) (\s -> "I'm afraid we don't like the " <> s.lastName <> " family around here.")

badFirstNames :: List String
badFirstNames = Cons "Bruce" $ Cons "Steve" $ Cons "Horse" $ Cons "Brad" $ Nil

badLastNames :: List String
badLastNames = Cons "Smith" $ Cons "Jones" $ Cons "Cleese" $ Cons "Sleaze" $ Nil