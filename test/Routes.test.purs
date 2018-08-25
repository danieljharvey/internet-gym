module Test.Routes where

import Prelude
import Effect (Effect)
import Test.Unit (suite, test)
import Test.Unit.Main (runTest)
import Test.Unit.Assert as Assert

import App.Routes (match, Route(..))

main :: Effect Unit
main = runTest do
  suite "Routes" do
    test "match" do
      Assert.assert "Match / root to HomePage" $ match "/" == Home
      Assert.assert "Match /page/1 root to FormPage" $ match "/page/1" == FormPage 1
      Assert.assert "Match /page/2 root to FormPage" $ match "/page/2" == FormPage 2
      Assert.assert "Match /what to NotFound" $ match "/what" == NotFound "/what"
      Assert.assert "Match /dogs to DogPage" $ match "/dogs" == DogPage
