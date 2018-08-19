module Test.PageOne.Reducer where

import Prelude
import Test.Spec (describe, it)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec.Runner (run)

main = run [consoleReporter] do
    describe "Page One Reducer" do
        it "Does nothing" $ pure unit