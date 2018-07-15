module App.Utils.Validation where

import Data.Monoid (class Monoid, mempty)
import Data.Show
import Data.Either (Either(..))
import Data.List (List(Nil, Cons), foldr)
import Prelude ((<>), ($), map)

type Validator a = forall b. (Show b) => a -> Either (List b) a

combineEithers :: forall a b. (Monoid b) => Either b a -> Either b a -> Either b a
combineEithers (Left str) (Left str2)  = Left $ str  <> str2
combineEithers (Left str) (Right _)    = Left $ str  <> mempty
combineEithers (Right _) (Left str2)   = Left $ str2 <> mempty
combineEithers (Right st) (Right st2)  = Right st

validator :: forall a b. (Show b) => (a -> Boolean) -> (a -> b) -> a -> Either (List b) a
validator predicate message state = case (predicate state) of
    true  -> Right state
    false -> Left $ Cons (message state) $ Nil

combineValidators :: forall a b. (Show b) => Array (a -> Either (List b) a) -> a -> Either (List b) a
combineValidators validators state = foldr combineEithers (Right state) results where
    results = map (\v -> v state) validators
