module App.Types.State where

import App.PageOne.State (PageOneState)
import App.PageTwo.State (PageTwoState)
import App.Routes (Route)
import App.Types.Dog (DogState)
import Data.Newtype (class Newtype)

newtype State
  = State {title :: String, route :: Route, loaded :: Boolean, pageOne :: PageOneState, pageTwo :: PageTwoState, dogs :: DogState}

derive instance newtypeState :: Newtype State _
