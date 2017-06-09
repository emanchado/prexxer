module Update exposing (..)

import Dict exposing (Dict)
import Routing
import Messages exposing (..)
import Models exposing (Model, Wardrobe, OutfitSelection)
import Ports exposing (redrawDoll, redrawEvent, calculateDrawerContainer, drawerContainerEvent)


calculateOutfitSel : Wardrobe -> (Int, Int) -> OutfitSelection
calculateOutfitSel wardrobe offsets =
  let
    multiplierX =
      wardrobe.dollWidth + wardrobe.spacerWidth

    multiplierY =
      wardrobe.dollHeight + wardrobe.spacerHeight

    ( offsetX, offsetY ) =
      offsets
  in
    OutfitSelection (offsetX // multiplierX) (offsetY // multiplierY)


toggleDictValue : String -> OutfitSelection -> Dict String OutfitSelection -> Dict String OutfitSelection
toggleDictValue key value dict =
  case Dict.get key dict of
    Just v ->
      if v == value then
        Dict.remove key dict
      else
        Dict.insert key value dict

    _ ->
      Dict.insert key value dict


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    UpdateLocation newLocation ->
      ( { model | route = Routing.parseLocation newLocation }, Cmd.none )

    SelectPart drawerId offsets ->
      let
        updatedSel =
          toggleDictValue
            drawerId
            (calculateOutfitSel model.wardrobe offsets)
            model.selectedOutfit

        updatedModel =
          { model | selectedOutfit = updatedSel }
      in
        ( updatedModel, redrawDoll (redrawEvent "final-doll" updatedModel) )

    SelectDrawerTab drawer ->
      ( { model | selectedDrawer = Just drawer.id }, Cmd.none )

    CalculateDrawerContainer drawerId ->
      ( model, calculateDrawerContainer (drawerContainerEvent drawerId model) )

    DrawerContainerResult resp ->
      let
        modifiedDrawers =
          List.map
            (\d ->
              if d.id == resp.drawerId then
                { d
                  | dimensions = Just resp.dimensions
                  , contentSquare = Just resp.coords
                }
              else
                d
            )
            model.wardrobe.drawers

        initialWardrobe =
          model.wardrobe

        modifiedWardrobe =
          { initialWardrobe | drawers = modifiedDrawers }
      in
        ( { model | wardrobe = modifiedWardrobe }, Cmd.none )

    PngExportResult dataUrl ->
      ( { model | dollAsDataURL = dataUrl }, Cmd.none )
