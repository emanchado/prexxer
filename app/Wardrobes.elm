module Wardrobes exposing (..)

import Models exposing (..)

initialWardrobe : Wardrobe
initialWardrobe =
  Wardrobe "pixel-people" "Pixel People" 64 112 4 4
    [ Drawer "skins" "Sprite Sheet - Skin.png"
    , Drawer "eyes" "Sprite Sheet - Eyes.png"
    , Drawer "hair" "Sprite Sheet - Hair.png"
    , Drawer "tops" "Sprite Sheet - Tops.png"
    , Drawer "bottoms" "Sprite Sheet - Bottoms.png"
    , Drawer "shoes" "Sprite Sheet - Shoes.png"
    ]
