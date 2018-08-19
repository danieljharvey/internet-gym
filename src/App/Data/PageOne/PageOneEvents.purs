module App.PageOne.Events where

import Pux.DOM.Events (DOMEvent)

data PageOneEvent
  = SignIn DOMEvent
  | ChangeFirstName DOMEvent
  | ChangeMiddleName DOMEvent
  | ChangeLastName DOMEvent
  | ChangeAge DOMEvent
  | ChangeLikesDogs DOMEvent