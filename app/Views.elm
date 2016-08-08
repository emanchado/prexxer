module Views exposing (..)

import List
import Json.Decode as Json exposing (..)
import Html exposing (Html, div, header, canvas, img, text)
import Html.Attributes exposing (id, class, width, height, src)
import Html.Events exposing (on, onClick)

import Models exposing (..)
import Messages exposing (..)

onClickWithOffsets : ((Float, Float) -> Result String Msg) -> Html.Attribute Msg
onClickWithOffsets messageFromOffsets =
  on "click" (customDecoder (object2 (,) ("offsetX" := float) ("offsetY" := float)) messageFromOffsets)

drawerView : Wardrobe -> Drawer -> Html Msg
drawerView wardrobe drawer =
  img [ class "drawer"
      , src ("/wardrobes/" ++ wardrobe.id ++ "/" ++ drawer.spriteUrl)
      , onClickWithOffsets (\offsets -> Ok (SelectPart drawer.id offsets))
      ] []

drawerTabView : Maybe Drawer -> Drawer -> Html Msg
drawerTabView maybeDrawer drawer =
  let
    extraClass = case maybeDrawer of
                   Just d -> if drawer == d then " active" else ""
                   Nothing -> ""
  in
    div [ class ("drawer-tab" ++ extraClass)
        , onClick (SelectDrawer drawer)
        ]
    [ text drawer.name ]

drawerSourceImageView : Wardrobe -> Drawer -> Html Msg
drawerSourceImageView wardrobe drawer =
  img [ id drawer.id
      , src ("/wardrobes/" ++ wardrobe.id ++ "/" ++ drawer.spriteUrl)
      ] []

wardrobeView : Wardrobe -> Maybe Drawer -> Html Msg
wardrobeView wardrobe maybeDrawer =
  let
    drawerTabList = List.map (drawerTabView maybeDrawer) wardrobe.drawers
    drawerSourceImages = List.map (drawerSourceImageView wardrobe) wardrobe.drawers
  in
    div [ class "wardrobe-content" ]
      [ div [ class "drawer-tabs" ] drawerTabList
      , div [ class "drawer-content" ]
        [ case maybeDrawer of
            Just selectedDrawer ->
              drawerView wardrobe selectedDrawer
            Nothing ->
              (case List.head wardrobe.drawers of
                 Just firstDrawer ->
                   drawerView wardrobe firstDrawer
                 Nothing ->
                   text "")
        ]
      , div [ class "drawer-source-images" ] drawerSourceImages
      ]

mainApplicationView : Model -> Html Msg
mainApplicationView model =
  div []
    [ header []
        [ div [ class "site-title" ] [ text "Doll Dresser" ]
        , div [ class "wardrobe-title" ] [ text ("Wardrobe: " ++ model.wardrobe.name) ]
        , text "(c) 2016"
        ]
    , div [ class "content" ]
      [ div [ class "result-container" ]
          [ canvas [ id "final-doll"
                   , width model.wardrobe.dollWidth
                   , height model.wardrobe.dollHeight
                   ] []
          ]
      , wardrobeView model.wardrobe model.selectedDrawer
      ]
    ]
