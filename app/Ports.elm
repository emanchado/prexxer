port module Ports exposing (redrawDoll, redrawEvent, calculateDrawerContainer, drawerContainerEvent, drawerContainerResponder, DrawerContainerInfo, pngExportResponder)

import Dict
import Models exposing (..)


type alias RedrawEvent =
    { dollCanvasId : String
    , wardrobe : Wardrobe
    , outfitSelections : List ( String, OutfitSelection )
    }


type alias DrawerContainerEvent =
    { drawerId : String
    , partWidth : Int
    , partHeight : Int
    }


type alias DrawerContainerInfo =
    { drawerId : String
    , dimensions : Dimensions
    , coords : SquareCoords
    }


port redrawDoll : RedrawEvent -> Cmd msg


port calculateDrawerContainer : DrawerContainerEvent -> Cmd msg


port drawerContainerResponder : (DrawerContainerInfo -> msg) -> Sub msg


port pngExportResponder : (String -> msg) -> Sub msg


redrawEvent : String -> Model -> RedrawEvent
redrawEvent dollId model =
    RedrawEvent dollId model.wardrobe (Dict.toList model.selectedOutfit)


drawerContainerEvent : String -> Model -> DrawerContainerEvent
drawerContainerEvent drawerId model =
    let
        partWidth =
            model.wardrobe.dollWidth + model.wardrobe.spacerWidth

        partHeight =
            model.wardrobe.dollHeight + model.wardrobe.spacerHeight
    in
        DrawerContainerEvent drawerId partWidth partHeight
