module App.Routes where

import Data.Eq
import Pux.Router

import Control.Alt ((<|>))
import Control.Apply ((<*), (*>))
import Data.Function (($))
import Data.Functor ((<$), (<$>))
import Data.Maybe (fromMaybe)
import Data.Semigroup ((<>))
import Data.Show (show)

data Route
  = Home
  | FormPage Int
  | DogPage
  | NotFound String

derive instance eqRoute :: Eq Route

match :: String -> Route
match url = fromMaybe (NotFound url) $ router url $ Home <$ end <|> DogPage <$ (lit "dogs") <* end <|> FormPage <$> (lit "page" *> int) <* end

toURL :: Route -> String
toURL (NotFound url) = url

toURL (Home) = "/"

toURL (FormPage num) = "/page/" <> show num

toURL (DogPage) = "/dogs"
