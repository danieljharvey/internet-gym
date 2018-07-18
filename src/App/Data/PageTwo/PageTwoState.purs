module App.PageTwo.State where

import Data.Show

data Animal = None
            | Dogses
            | Horses
            | Catses
            | Pigses
            | Moose 
            | Pelican 
            | Beetle 
            | Steve 

instance showAnimal :: Show Animal where
    show Dogses  = "Dogses"
    show Horses  = "Horses"
    show Catses  = "Catses"
    show Pigses  = "Pigses"
    show Moose   = "Moose"
    show Pelican = "Pelican"
    show Beetle  = "Beetle"
    show Steve   = "Steve"
    show None    = ""

type PageTwoState = {
    firstLine   :: String,
    secondLine  :: String,
    city        :: String,
    postCode    :: String,
    phoneNumber :: String,
    animal      :: Animal
}

initialPageTwoState :: PageTwoState
initialPageTwoState = {
  firstLine: "",
  secondLine: "",
  city: "",
  postCode: "",
  phoneNumber: "",
  animal: None
}
