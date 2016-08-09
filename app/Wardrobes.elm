module Wardrobes exposing (..)

import Models exposing (..)

initialWardrobe : Wardrobe
initialWardrobe =
  Wardrobe "pixel-people" "Pixel People" 64 112 4 4
    [ Drawer "skins" "Skins" "Sprite Sheet - Skin.png" Nothing Nothing
    , Drawer "eyes" "Eyes" "Sprite Sheet - Eyes.png" Nothing Nothing
    , Drawer "hair" "Hairstyles" "Sprite Sheet - Hair.png" Nothing Nothing
    , Drawer "tops" "Tops" "Sprite Sheet - Tops.png" Nothing Nothing
    , Drawer "bottoms" "Bottoms" "Sprite Sheet - Bottoms.png" Nothing Nothing
    , Drawer "shoes" "Shoes" "Sprite Sheet - Shoes.png" Nothing Nothing
    ]
