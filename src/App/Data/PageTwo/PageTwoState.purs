module App.PageTwo.State where
  
type PageTwoState = {
    firstLine   :: String,
    secondLine  :: String,
    city        :: String,
    postCode    :: String,
    phoneNumber :: String
}

initialPageTwoState :: PageTwoState
initialPageTwoState = {
  firstLine: "",
  secondLine: "",
  city: "",
  postCode: "",
  phoneNumber: ""
}