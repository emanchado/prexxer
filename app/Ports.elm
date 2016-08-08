port module Ports exposing (redrawDoll, redrawEvent)

import Dict

import Models exposing (..)

type alias RedrawEvent =
  { dollCanvasId : String
  , wardrobe : Wardrobe
  , outfitSelections : List (String, OutfitSelection)
  }

port redrawDoll : RedrawEvent -> Cmd msg

redrawEvent : Model -> RedrawEvent
redrawEvent model =
  RedrawEvent "final-doll" model.wardrobe (Dict.toList model.selectedOutfit)
