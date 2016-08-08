module Update exposing (..)

import Dict

import Routing
import Messages exposing (..)
import Models exposing (Model, Wardrobe, OutfitSelection)
import Ports exposing (redrawDoll, redrawEvent)

urlUpdate : Result String Routing.Route -> Model -> (Model, Cmd Msg)
urlUpdate result model =
  let
    currentRoute =
      Routing.routeFromResult result
  in
    ({ model | route = currentRoute }, Cmd.none)

calculateOutfitSel : Wardrobe -> (Float, Float) -> OutfitSelection
calculateOutfitSel wardrobe offsets =
  let
    multiplierX = wardrobe.dollWidth + wardrobe.spacerWidth
    multiplierY = wardrobe.dollHeight + wardrobe.spacerHeight
    (offsetX, offsetY) = offsets
  in
    OutfitSelection (floor (offsetX / (toFloat multiplierX)))
      (floor (offsetY / (toFloat multiplierY)))

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Refresh ->
      (model, redrawDoll (redrawEvent model))

    SelectPart drawerId offsets ->
      let
        initialSel = model.selectedOutfit
        updatedSel = Dict.insert drawerId (calculateOutfitSel model.wardrobe offsets) initialSel
        updatedModel = { model | selectedOutfit = updatedSel }
      in
        (updatedModel, redrawDoll (redrawEvent updatedModel))
