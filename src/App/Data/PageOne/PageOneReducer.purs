module App.PageOne.Reducer where

import App.PageOne.Events (PageOneEvent(..))
import App.PageOne.State (PageOneState)
import Data.Int (fromString)
import Data.Maybe (Maybe(..))
import Prelude (not)
import Pux.DOM.Events (targetValue)

-- this is a simplified reducer that returns no effects, just State
foldp ::
  PageOneEvent ->
  PageOneState ->
  PageOneState
foldp (ChangeFirstName ev) pageOne = pageOne { firstName = (targetValue ev) }

foldp (ChangeLastName ev) pageOne = pageOne { lastName = (targetValue ev) }

foldp (ChangeMiddleName ev) pageOne = pageOne { middleName = (targetValue ev) }

foldp (ChangeAge ev) pageOne = case (fromString (targetValue ev)) of
  Just age -> pageOne { age = age }
  _ -> pageOne

foldp (ChangeLikesDogs ev) pageOne = pageOne { likesDogs = not pageOne.likesDogs }

foldp _ state = state
