module App.Types.State where

import App.Routes (Route)
import Data.Newtype (class Newtype)
import App.Types.Dog (DogState)
import App.PageOne.State (PageOneState)
import App.PageTwo.State (PageTwoState)

newtype State = State {
    title   :: String
  , route   :: Route
  , loaded  :: Boolean
  , pageOne :: PageOneState
  , pageTwo :: PageTwoState
  , dogs    :: DogState
}

derive instance newtypeState :: Newtype State _
