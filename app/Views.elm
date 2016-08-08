module Views exposing (..)

import List
import Json.Decode as Json exposing (..)
import Html exposing (Html, div, canvas, img, text)
import Html.Attributes exposing (id, class, width, height, src)
import Html.Events exposing (on)

import Models exposing (..)
import Messages exposing (..)

onClickWithOffsets messageFromOffsets =
  on "click" (customDecoder (object2 (,) ("offsetX" := float) ("offsetY" := float)) messageFromOffsets)

drawerView : Wardrobe -> Drawer -> Html Msg
drawerView wardrobe drawer =
  img [ id drawer.id
      , src ("/wardrobes/" ++ wardrobe.id ++ "/" ++ drawer.spriteUrl)
      , onClickWithOffsets (\offsets -> Ok (SelectPart drawer.id offsets))
      ] []

wardrobeView : Wardrobe -> Html Msg
wardrobeView wardrobe =
  let
    drawerList = List.map (\d -> drawerView wardrobe d) wardrobe.drawers
  in
    div []
      (List.append
         [ text ("Wardrobe " ++ wardrobe.name) ] 
         drawerList)

mainApplicationView : Model -> Html Msg
mainApplicationView model =
  div []
    [ canvas [ id "final-doll"
             , width model.wardrobe.dollWidth
             , height model.wardrobe.dollHeight
             ] []
    , wardrobeView model.wardrobe
    ]
