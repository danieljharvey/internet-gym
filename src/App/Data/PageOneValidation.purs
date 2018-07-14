module App.PageOne.Validation where

import Prelude ((==), compare, Ordering(GT), (=<<), (>))
import App.State (PageOneState)
import Data.Either (Either(..))
import Data.String.CodeUnits (length)

validateState :: PageOneState -> Either String PageOneState
validateState state = isLikesDogs =<< isOverTen state

isLikesDogs :: PageOneState -> Either String PageOneState
isLikesDogs state = case (state.likesDogs == false) of
    true  -> Right state
    false -> Left "No dog love please, this is a place of hygiene"

isOverTen :: PageOneState -> Either String PageOneState
isOverTen state = case (compare state.age 10) == GT of 
    true  -> Right state
    false -> Left "Absolutely too young for this damn gym"

noFirstName :: PageOneState -> Either String PageOneState
noFirstName state = case (length state.firstName) > 3 of 
    true  -> Right state
    false -> Left "First name is too short"