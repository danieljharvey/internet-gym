module App.State where

import App.PageOne.State (PageOneState, initialPageOneState)
import App.PageTwo.State (PageTwoState, initialPageTwoState)
import App.Routes (Route, match)
import Data.Newtype (class Newtype)
import App.Dog

import App.Config (config)
import App.Routes (match)
import App.Types.State
import App.Types.Dog (DogState)

initialDogState :: DogState
initialDogState = { dogs: [], status: "Nothing loaded from server yet" }

init :: String -> State
init url = State
  { title: config.title
  , route: match url
  , loaded: false
  , pageOne: initialPageOneState
  , pageTwo: initialPageTwoState
  , dogs: initialDogState
  }


  