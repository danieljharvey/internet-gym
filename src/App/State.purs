module App.State where

import App.PageOne.State (initialPageOneState)
import App.PageTwo.State (initialPageTwoState)
import App.Routes (match)

import App.Config (config)
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
  