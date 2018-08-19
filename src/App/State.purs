module App.State where

import App.Config (config)
import App.PageOne.State (PageOneState, initialPageOneState)
import App.PageTwo.State (PageTwoState, initialPageTwoState)
import App.Routes (Route, match)
import Data.Newtype (class Newtype)
import App.Dog

newtype State = State {
    title   :: String
  , route   :: Route
  , loaded  :: Boolean
  , pageOne :: PageOneState
  , pageTwo :: PageTwoState
  , dogs    :: DogState
}

derive instance newtypeState :: Newtype State _

init :: String -> State
init url = State
  { title: config.title
  , route: match url
  , loaded: false
  , pageOne: initialPageOneState
  , pageTwo: initialPageTwoState
  , dogs: initialDogState
  }
