module App.State where

import App.Config (config)
import App.Routes (match)
import App.Types.State
import App.Types.Dog (DogState)

initialPageOneState :: PageOneState
initialPageOneState = {
  firstName: "",
  lastName: "",
  middleName: "",
  age: 0,
  likesDogs: false
}

initialDogState :: DogState
initialDogState = { dogs: [], status: "Nothing loaded from server yet" }


init :: String -> State
init url = State
  { title: config.title
  , route: match url
  , loaded: false
  , pageOne: initialPageOneState
  , dogs: initialDogState
  }


  