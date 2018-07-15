module App.PageTwo.Events where

import Pux.DOM.Events (DOMEvent)

data PageTwoEvent
  = SignIn DOMEvent
  | ChangeFirstLine DOMEvent
  | ChangeSecondLine DOMEvent
  | ChangeCity DOMEvent
  | ChangePostCode DOMEvent
  | ChangePhoneNumber DOMEvent