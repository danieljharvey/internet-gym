module App.State where

import App.Config (config)
import App.Routes (Route, match)
import Data.Newtype (class Newtype)

type PageOneState = {
    name :: String,
    age :: Int
}

newtype State = State
  { title :: String
  , route :: Route
  , loaded :: Boolean
  , pageOne :: PageOneState
}



derive instance newtypeState :: Newtype State _

initialPageOneState :: PageOneState
initialPageOneState = {
  name: "",
  age: 0
}

init :: String -> State
init url = State
  { title: config.title
  , route: match url
  , loaded: false
  , pageOne: initialPageOneState
  }
