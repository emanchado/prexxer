module Update exposing (..)

import Dict exposing (Dict)

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

toggleDictValue : String -> OutfitSelection -> Dict String OutfitSelection -> Dict String OutfitSelection
toggleDictValue key value dict =
  case Dict.get key dict of
    Just v ->
      if v == value then Dict.remove key dict else Dict.insert key value dict
    _ ->
      Dict.insert key value dict

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Refresh ->
      (model, redrawDoll (redrawEvent model))

    SelectPart drawerId offsets ->
      let
        initialSel = model.selectedOutfit
        updatedSel = toggleDictValue drawerId (calculateOutfitSel model.wardrobe offsets) initialSel
        updatedModel = { model | selectedOutfit = updatedSel }
      in
        (updatedModel, redrawDoll (redrawEvent updatedModel))

    SelectDrawer drawer ->
      ({ model | selectedDrawer = Just drawer }, Cmd.none)
