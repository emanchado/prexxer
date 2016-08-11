module Views exposing (..)

import List
import Json.Decode as Json exposing (..)
import Html exposing (Html, div, header, canvas, img, a, text, pre)
import Html.Attributes exposing (id, class, downloadAs, style, width, height, src, href)
import Html.Events exposing (on, onClick)

import Models exposing (..)
import Messages exposing (..)

onClickWithOffsets : ((Float, Float) -> Result String Msg) -> Html.Attribute Msg
onClickWithOffsets messageFromOffsets =
  on "click" (customDecoder (object2 (,) ("offsetX" := float) ("offsetY" := float)) messageFromOffsets)

drawerParts : String -> String -> Dimensions -> (Int, Int) -> SquareCoords -> (Int, Int) -> List (Html Msg)
drawerParts drawerId spriteUrl dimensions partDimensions square offset =
  if (snd offset) >= dimensions.height then
    []
  else
    let
      offsetX = square.x + (fst offset) - 1
      offsetY = square.y + (snd offset) - 1
      nextHorizontalOffset = (fst offset) + (fst partDimensions)
      nextOffset = if nextHorizontalOffset >= dimensions.width then
                     (0, (snd offset) + (snd partDimensions))
                   else
                     (nextHorizontalOffset, (snd offset))
    in
      List.append
        [ div [ class "drawer-part"
              , style [ ("width", (toString (max 50 square.width)) ++ "px")
                      , ("height", (toString (max 50 square.height)) ++ "px")
                      ]
              , onClick (SelectPart drawerId offset)
              ]
            [ div [ style [ ("width", (toString square.width) ++ "px")
                          , ("height", (toString square.height) ++ "px")
                          , ("background-image", "url('" ++ spriteUrl ++ "')")
                          , ("background-repeat", "no-repeat")
                          , ("background-position", "-" ++ (toString offsetX) ++ "px -" ++ (toString offsetY) ++ "px")
                          ]
                  ]
                []
            ]
        ]
        (drawerParts
           drawerId
           spriteUrl
           dimensions
           partDimensions
           square
           nextOffset)

drawerView : Wardrobe -> Drawer -> Html Msg
drawerView wardrobe drawer =
  let
    drawerImageUrl = "/wardrobes/" ++ wardrobe.id ++ "/" ++ drawer.spriteUrl
    partWidth = wardrobe.dollWidth + wardrobe.spacerWidth
    partHeight = wardrobe.dollHeight + wardrobe.spacerHeight
  in
    case drawer.contentSquare of
      Just square ->
        case drawer.dimensions of
          Just dimensions ->
            div [ class "parts" ]
              (drawerParts drawer.id drawerImageUrl dimensions (partWidth, partHeight) square (0, 0))
          Nothing ->
            text "Internal error: found contentSquare but not dimensions"
      Nothing ->
        img [ style [ ("display", "none") ]
            , src drawerImageUrl
            , on "load" (Json.succeed (CalculateContentSquare drawer.id))
            ] []

drawerTabView : Maybe String -> Drawer -> Html Msg
drawerTabView maybeDrawerId drawer =
  let
    extraClass = case maybeDrawerId of
                   Just id -> if drawer.id == id then " active" else ""
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

wardrobeView : Wardrobe -> Maybe String -> Html Msg
wardrobeView wardrobe maybeDrawerId =
  let
    drawerTabList = List.map (drawerTabView maybeDrawerId) wardrobe.drawers
    drawerSourceImages = List.map (drawerSourceImageView wardrobe) wardrobe.drawers
  in
    div [ class "wardrobe-content" ]
      [ div [ class "drawer-tabs" ] drawerTabList
      , div [ class "drawer-content" ]
        [ case maybeDrawerId of
            Just selectedDrawerId ->
              case List.head (List.filter (\d -> d.id == selectedDrawerId) wardrobe.drawers) of
                Just selectedDrawer -> drawerView wardrobe selectedDrawer
                Nothing -> text "error!"
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
        [ div [ class "site-title" ] [ text "Prexxer" ]
        , div [ class "wardrobe-title" ] [ text ("Wardrobe: " ++ model.wardrobe.name) ]
        ]
    , div [ class "content" ]
        [ div [ class "result-container" ]
            [ canvas [ id "final-doll"
                     , width model.wardrobe.dollWidth
                     , height model.wardrobe.dollHeight
                     ] []
            , a [ class "button"
                , downloadAs "doll.png"
                , href model.dollAsDataURL
                -- , onClick (PngExport "final-doll")
                ]
                [ text "Export" ]
            ]
        , wardrobeView model.wardrobe model.selectedDrawer
        ]
    -- , pre [ class "debugging" ]
    --     [ text (toString model) ]
    ]
