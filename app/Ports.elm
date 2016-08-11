port module Ports exposing (redrawDoll, redrawEvent, drawerContainerCoords, containerCoordsEvent, foundDrawerContainer, DrawerContainerResponse, pngExport, pngExportResponse)

import Dict

import Models exposing (..)

type alias RedrawEvent =
  { dollCanvasId : String
  , wardrobe : Wardrobe
  , outfitSelections : List (String, OutfitSelection)
  }

type alias ContainerCoordsEvent =
  { imageId : String
  , partWidth : Int
  , partHeight : Int
  }

type alias DrawerContainerResponse =
  { drawerId : String
  , dimensions : Dimensions
  , coords : SquareCoords
  }

port redrawDoll : RedrawEvent -> Cmd msg

port drawerContainerCoords : ContainerCoordsEvent -> Cmd msg

port foundDrawerContainer : (DrawerContainerResponse -> msg) -> Sub msg

port pngExport : String -> Cmd msg

port pngExportResponse : (String -> msg) -> Sub msg

redrawEvent : Model -> RedrawEvent
redrawEvent model =
  RedrawEvent "final-doll" model.wardrobe (Dict.toList model.selectedOutfit)

containerCoordsEvent : String -> Model -> ContainerCoordsEvent
containerCoordsEvent drawerId model =
  let
    partWidth = model.wardrobe.dollWidth + model.wardrobe.spacerWidth
    partHeight = model.wardrobe.dollHeight + model.wardrobe.spacerHeight
  in
    ContainerCoordsEvent drawerId partWidth partHeight
