module App.PageOne.Reducer where

import App.State (State(..))
import App.PageOne.Events (PageOneEvent(..))
import Pux.DOM.Events (targetValue)
import Data.Maybe (Maybe(..))
import Data.Int (fromString)

-- this is a simplified reducer that returns no effects, just State
foldp :: PageOneEvent -> State -> State
foldp (ChangeName ev) state = changeName (targetValue ev) state

foldp (ChangeAge ev) state = changeAge (targetValue ev) state

foldp _ state
  = state

changeName :: String -> State -> State
changeName name (State st) = State st { pageOne = { name : name, age: st.pageOne.age } }

changeAge :: String -> State -> State
changeAge ageString (State st) = case (fromString ageString) of
    Just age -> State st { pageOne = { name : st.pageOne.name, age: age } }
    _ -> State st
    