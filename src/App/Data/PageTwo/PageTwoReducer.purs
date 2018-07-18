module App.PageTwo.Reducer where

import App.PageTwo.State (PageTwoState, Animal(..))
import App.PageTwo.Events (PageTwoEvent(..))
import Prelude (($))
import Pux.DOM.Events (targetValue)

-- this is a simplified reducer that returns no effects, just State
foldp :: PageTwoEvent -> PageTwoState -> PageTwoState
foldp (ChangeFirstLine ev) pageTwo = pageTwo { firstLine = targetValue ev }
foldp (ChangeSecondLine ev) pageTwo = pageTwo { secondLine = targetValue ev }
foldp (ChangeCity ev) pageTwo = pageTwo { city = targetValue ev}
foldp (ChangePostCode ev) pageTwo = pageTwo { postCode = targetValue ev }
foldp (ChangePhoneNumber ev) pageTwo = pageTwo { phoneNumber = targetValue ev }
foldp (ChangeAnimal ev) pageTwo = pageTwo { animal = getAnimal $ targetValue ev }
foldp _ pageTwo = pageTwo

getAnimal :: String -> Animal
getAnimal "Dogses" = Dogses
getAnimal _     = None
