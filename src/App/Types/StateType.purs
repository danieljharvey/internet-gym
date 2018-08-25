module App.Types.State where

import App.Routes (Route)
import Data.Newtype (class Newtype)
import App.Types.Dog (DogState)

type PageOneState = {
    firstName  :: String,
    lastName   :: String,
    middleName :: String,
    age        :: Int,
    likesDogs  :: Boolean
}

newtype State = State {
    title   :: String
  , route   :: Route
  , loaded  :: Boolean
  , pageOne :: PageOneState
  , dogs    :: DogState
}

derive instance newtypeState :: Newtype State _
