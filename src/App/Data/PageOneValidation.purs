module App.PageOne.Validation where

import Data.Monoid
import Data.Show

import App.State (PageOneState)
import Data.Either (Either(..))
import Data.List (List(..), elem)
import Data.Monoid (mempty)
import Prelude ((==), compare, Ordering(GT), (<>), ($), not, const)

data PageOneError = NoDogs | TooYoung | BadFirstName String | BadLastName String

instance showPageOneError :: Show PageOneError where
  show NoDogs              = "No dog love please, this is a place of hygiene."
  show TooYoung            = "Absolutely too young for this damn gym."
  show (BadFirstName name) = "I'm afraid we don't allow " <> name <> "s in here."
  show (BadLastName name)  = "I'm afraid we don't like the " <> name <> " family around here."
  show _                   = "Other error"

validateState :: PageOneState -> Either (List PageOneError) PageOneState
validateState state = isLikesDogs state `combineEithers` isOverTen state `combineEithers` badFirstName state `combineEithers` badLastName state

combineEithers :: forall a b. (Monoid b) => Either b a -> Either b a -> Either b a
combineEithers (Left str) (Left str2)  = Left $ str  <> str2
combineEithers (Left str) (Right _)    = Left $ str  <> mempty
combineEithers (Right _) (Left str2)   = Left $ str2 <> mempty
combineEithers (Right st) (Right st2)  = Right st

validator :: forall a b. (Show b) => (a -> Boolean) -> (a -> b) -> a -> Either (List b) a
validator predicate message state = case (predicate state) of
    true  -> Right state
    false -> Left $ Cons (message state) $ Nil

isLikesDogs :: PageOneState -> Either (List PageOneError) PageOneState
isLikesDogs = validator (\s -> s.likesDogs == false) (const NoDogs)

isOverTen :: PageOneState -> Either (List PageOneError) PageOneState
isOverTen = validator (\s -> (compare s.age 10) == GT) (const TooYoung)

badFirstName :: PageOneState -> Either (List PageOneError) PageOneState
badFirstName = validator (\s -> not $ elem s.firstName badFirstNames) (\s -> BadFirstName s.firstName)

badLastName :: PageOneState -> Either (List PageOneError) PageOneState
badLastName = validator (\s -> not $ elem s.lastName badLastNames) (\s -> BadLastName s.lastName)

badFirstNames :: List String
badFirstNames = Cons "Bruce" $ Cons "Steve" $ Cons "Horse" $ Cons "Brad" $ Nil

badLastNames :: List String
badLastNames = Cons "Smith" $ Cons "Jones" $ Cons "Cleese" $ Cons "Sleaze" $ Nil