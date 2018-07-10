module App.PageOne.Events where

import Pux.DOM.Events (DOMEvent)

data PageOneEvent
  = SignIn DOMEvent
  | ChangeName DOMEvent
  | ChangeAge DOMEvent
  | ChangeLikesDogs DOMEvent