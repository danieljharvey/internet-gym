module App.PageOne.Reducer where

import App.State (PageOneState)
import App.PageOne.Events (PageOneEvent(..))
import Pux.DOM.Events (targetValue)
import Data.Maybe (Maybe(..))
import Data.Int (fromString)

-- this is a simplified reducer that returns no effects, just State
foldp :: PageOneEvent -> PageOneState -> PageOneState
foldp (ChangeName ev) pageOne = pageOne { name = (targetValue ev) }
foldp (ChangeAge ev) pageOne = case (fromString (targetValue ev)) of
    Just age -> pageOne { age = age }
    _ -> pageOne
foldp (ChangeLikesDogs ev) pageOne = pageOne { likesDogs = bool } where
    bool = case (targetValue ev) of 
        "1" -> true
        _ -> false

foldp _ state
  = state

