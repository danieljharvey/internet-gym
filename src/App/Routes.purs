module App.Routes where

import Data.Eq
import Data.Function (($))
import Data.Functor ((<$), (<$>))
import Data.Semigroup ((<>))
import Data.Show (show)
import Control.Apply ((<*),(*>))
import Data.Maybe (fromMaybe)
import Pux.Router
import Control.Alt ((<|>))

data Route = Home | FormPage Int | DogPage | NotFound String

derive instance eqRoute :: Eq Route

match :: String -> Route
match url = fromMaybe (NotFound url) $ router url $
  Home <$ end
  <|>
  DogPage <$ (lit "dogs") <* end
  <|>
  FormPage <$> (lit "page" *> int) <* end

toURL :: Route -> String
toURL (NotFound url) = url
toURL (Home) = "/"
toURL (FormPage num) = "/page/" <> show num
toURL (DogPage) = "/dogs"