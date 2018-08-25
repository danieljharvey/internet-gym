module App.PageOne.State where

type PageOneState
  = {firstName :: String, lastName :: String, middleName :: String, age :: Int, likesDogs :: Boolean}

initialPageOneState :: PageOneState
initialPageOneState = { firstName: ""
                      , lastName: ""
                      , middleName: ""
                      , age: 0
                      , likesDogs: false
                      }
