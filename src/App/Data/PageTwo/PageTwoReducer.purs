module App.PageTwo.Reducer where

import App.PageTwo.State (PageTwoState)
import App.PageTwo.Events (PageTwoEvent)
-- import Pux.DOM.Events (targetValue)
-- import Data.Maybe (Maybe(..))
-- import Data.Int (fromString)

-- this is a simplified reducer that returns no effects, just State
foldp :: PageTwoEvent -> PageTwoState -> PageTwoState
foldp _ pageTwo = pageTwo
