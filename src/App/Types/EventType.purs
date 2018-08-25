module App.Types.Event where

import App.Types.Dog (Dog)
import App.PageOne.Events (PageOneEvent)
import App.PageTwo.Events (PageTwoEvent)
import App.Routes (Route)

import Data.Either (Either)
import Pux.DOM.Events (DOMEvent)

data Event
  = PageView Route
  | Navigate String DOMEvent
  | PageOne (PageOneEvent)
  | PageTwo (PageTwoEvent)
  | RequestDogs
  | ReceiveDogs (Either String Dog)
  