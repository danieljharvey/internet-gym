module App.PageTwo.Reducer where

import Prelude (not)
import App.State (PageTwoState)
import App.PageTwo.Events (PageTwoEvent(..))
import Pux.DOM.Events (targetValue)
import Data.Maybe (Maybe(..))
import Data.Int (fromString)

-- this is a simplified reducer that returns no effects, just State
foldp :: PageTwoEvent -> PageTwoState -> PageTwoState
foldp (ChangeFirstName ev) pageTwo = pageTwo { firstName = (targetValue ev) }
foldp (ChangeLastName ev) pageTwo = pageTwo { lastName = (targetValue ev) }
foldp (ChangeMiddleName ev) pageTwo = pageTwo { middleName = (targetValue ev) }
foldp (ChangeAge ev) pageTwo = case (fromString (targetValue ev)) of
    Just age -> pageTwo { age = age }
    _ -> pageTwo

foldp (ChangeLikesDogs ev) pageTwo = pageTwo { likesDogs = not pageTwo.likesDogs }

foldp _ state
  = state

