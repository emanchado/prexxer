module Wardrobes exposing (..)

import Models exposing (..)

initialWardrobe : Wardrobe
initialWardrobe =
  Wardrobe "pixel-people" "Pixel People" 64 112 4 4
    [ Drawer "skins" "Skins" "Sprite Sheet - Skin.png"
    , Drawer "eyes" "Eyes" "Sprite Sheet - Eyes.png"
    , Drawer "hair" "Hairstyles" "Sprite Sheet - Hair.png"
    , Drawer "tops" "Tops" "Sprite Sheet - Tops.png"
    , Drawer "bottoms" "Bottoms" "Sprite Sheet - Bottoms.png"
    , Drawer "shoes" "Shoes" "Sprite Sheet - Shoes.png"
    ]
