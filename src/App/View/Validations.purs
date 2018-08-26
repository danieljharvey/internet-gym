module App.View.Validations where

import Data.Maybe

import Control.Monad.Free (Free)
import Data.Either (Either(..))
import Data.Eq (class Eq)
import Data.List (List, elemIndex)
import Prelude (Unit)
import Text.Smolder.HTML (div)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup ((!), MarkupM)

isInvalid :: forall a b. Eq a => a -> Either (List a) b -> Boolean
isInvalid error valid = case valid of
  (Left errors) -> isJust (elemIndex error errors)
  Right _ -> false

addValidationClass :: forall a b. Eq a => a -> Either (List a) b -> String
addValidationClass error valid = case (isInvalid error valid) of
  true -> "formSection invalid"
  _ -> "formSection"

makeValidDiv ::
  forall a b c.
  Eq a =>
  a ->
  Either (List a) b ->
  Free (MarkupM c) Unit ->
  Free (MarkupM c) Unit
makeValidDiv error validated = div ! className (addValidationClass error validated)
