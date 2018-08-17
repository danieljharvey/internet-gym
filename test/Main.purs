module Test.Main where

import Prelude
import Effect
import Control.Logger.Console (CONSOLE, log)

main :: forall e. Eff (console :: CONSOLE | e) Unit
main = do
  log "You should add some tests."
