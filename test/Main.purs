module Test.Main where

import Prelude
import Effect (Effect)
import Test.Routes as Routes

main :: Effect Unit
main = do
  Routes.main
