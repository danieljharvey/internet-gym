module App.Routes where

import Data.Function (($))
import Data.Functor ((<$), (<$>))
import Data.Semigroup ((<>))
import Data.Show (show)
import Control.Apply ((<*),(*>))
import Data.Maybe (fromMaybe)
import Pux.Router (end, router, lit,int)
import Control.Alt ((<|>))

data Route = Home | FormPage Int | NotFound String

match :: String -> Route
match url = fromMaybe (NotFound url) $ router url $
  Home <$ end
  <|>
  FormPage <$> (lit "page" *> int) <* end

toURL :: Route -> String
toURL (NotFound url) = url
toURL (Home) = "/"
toURL (FormPage num) = "/page/" <> show num