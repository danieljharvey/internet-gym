module App.View.Layout where

import App.Events (Event)
import App.Routes (Route(..))
import App.State (State(..))
import App.View.Homepage as Homepage
import App.View.NotFound as NotFound
import App.View.PageOne as PageOne
import CSS (CSS, alignItems, backgroundColor, borderRadius, color, display, flex, flexGrow, fontSize, fromString, inlineBlock, justifyContent, key, margin, marginLeft, marginRight, marginTop, padding, px, spaceBetween, value, (?))
import CSS.Border (border, solid)
import CSS.Common (baseline)
import CSS.Flexbox (flexDirection, column, row)
import CSS.Text (textDecoration, noneTextDecoration, letterSpacing)
import CSS.Text.Transform (textTransform, uppercase)
import CSS.TextAlign (center, textAlign)
import Color (rgb)
import Control.Bind (discard)
import Data.Function (($), (#))
import Pux.DOM.HTML (HTML, style)
import Text.Smolder.HTML (div)
import Text.Smolder.HTML.Attributes (className)
import Text.Smolder.Markup ((!))

view :: State -> HTML Event
view (State st) =
  div ! className "app" $ do
    style css

    case st.route of
      (Home) -> Homepage.view (State st)
      (FormPage _) -> PageOne.view (State st)
      (NotFound url) -> NotFound.view (State st)

css :: CSS
css = do
  let red = rgb 196 100 34
      green = rgb 14 196 172
      blue = rgb 14 154 196
      white = rgb 250 250 250
      grey = rgb 64 64 64

  fromString "body" ? do
    backgroundColor (rgb 0 20 30)
    key (fromString "font-family") (value "-apple-system,BlinkMacSystemFont,\"Segoe UI\",Roboto,Oxygen-Sans,Ubuntu,Cantarell,\"Helvetica Neue\",sans-serif")
    color white
    textAlign center

  fromString "h1" ? do
    fontSize (48.0 #px)
    marginTop (48.0 #px)
    textTransform uppercase
    letterSpacing (6.0 #px)

  fromString "form.pageOne" ? do
    fontSize (16.0 #px)
    margin (20.0 #px) (20.0 #px) (20.0 #px) (20.0 #px)
    backgroundColor (rgb 160 180 180)
    display flex
    flexDirection column
  
  fromString "div.formSection" ? do
    padding (10.0 #px) (10.0 #px) (10.0 #px) (10.0 #px)
    margin (10.0 #px) (10.0 #px) (10.0 #px) (10.0 #px)
    display flex
    flexDirection row
    alignItems baseline
    justifyContent spaceBetween
  
  fromString ".formSection input" ? do
    display flex
    flexGrow 2
    padding (10.0 #px) (10.0 #px) (10.0 #px) (10.0 #px)

  fromString ".formSection label" ? do
    flexGrow 1
    display flex

  fromString "button" ? do
    padding (10.0 #px) (20.0 #px) (10.0 #px) (20.0 #px)
    border solid (2.0 #px) green
    color green
    marginRight (10.0 #px)
    flexGrow 1

  fromString ".homePage a" ? do
    display inlineBlock
    borderRadius (2.0 #px) (2.0 #px) (2.0 #px) (2.0 #px)
    padding (6.0 #px) (6.0 #px) (6.0 #px) (6.0 #px)
    textDecoration noneTextDecoration

  fromString ".homePage .guide" ? do
    border solid (2.0 #px) green
    color green
    marginRight (10.0 #px)

  fromString ".homePage .guide:hover" ? do
    backgroundColor green
    color white

  fromString ".homePage .github" ? do
    border solid (2.0 #px) blue
    color blue
    marginLeft (10.0 #px)
    marginRight (10.0 #px)

  fromString ".homePage .github:hover" ? do
    backgroundColor blue
    color white

  fromString ".homePage .pageOne" ? do
    border solid (2.0 #px) red
    color red
    marginLeft (10.0 #px)
    marginRight (10.0 #px)

  fromString ".homePage .pageOne:hover" ? do
    backgroundColor red
    color white