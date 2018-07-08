module App.PageOne.Reducer where

import App.State (State(..))
import Data.Maybe (Maybe(..))
import Data.Int (fromString)

-- Reducer-esq functions for PageOne
-- each one takes state and something and returns new state
-- assuming no effects for now

changeName :: String -> State -> State
changeName name (State st) = State st { pageOne = { name : name, age: st.pageOne.age } }

changeAge :: String -> State -> State
changeAge ageString (State st) = case (fromString ageString) of
    Just age -> State st { pageOne = { name : st.pageOne.name, age: age } }
    _ -> State st
    