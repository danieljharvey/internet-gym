module App.State where

import App.Config (config)
import App.Routes (Route, match)
import Data.Newtype (class Newtype)

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
}

derive instance newtypeState :: Newtype State _

initialPageOneState :: PageOneState
initialPageOneState = {
  firstName: "",
  lastName: "",
  middleName: "",
  age: 0,
  likesDogs: false
}

init :: String -> State
init url = State
  { title: config.title
  , route: match url
  , loaded: false
  , pageOne: initialPageOneState
  }
