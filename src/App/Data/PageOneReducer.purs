module App.PageOne.Reducer where

import App.State (State(..))

-- Reducer-esq functions for PageOne
-- each one takes state and something and returns new state
-- assuming no effects for now

changeName :: State -> String -> State
changeName (State st) name = State st { pageOne = { name : name, age: 0 } }