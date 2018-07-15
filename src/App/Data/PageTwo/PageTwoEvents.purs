module App.PageTwo.Events where

import Pux.DOM.Events (DOMEvent)

data PageTwoEvent
  = SignIn DOMEvent
  | ChangeFirstName DOMEvent
  | ChangeMiddleName DOMEvent
  | ChangeLastName DOMEvent
  | ChangeAge DOMEvent
  | ChangeLikesDogs DOMEvent