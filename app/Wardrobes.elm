module Wardrobes exposing (..)

import Models exposing (..)

initialWardrobe : Wardrobe
initialWardrobe =
  Wardrobe "pixel-people" "Pixel People" 64 112 4 4
    [ Drawer "skins" "Skins" "Sprite Sheet - Skin.png" Nothing Nothing
    , Drawer "eyes" "Eyes" "Sprite Sheet - Eyes.png" Nothing Nothing
    , Drawer "hair" "Hair" "Sprite Sheet - Hair.png" Nothing Nothing
    , Drawer "hair2" "Hair 2" "extras2/Hair Sprite Sheet.png" Nothing Nothing
    , Drawer "hats" "Hats" "extras2/Hats Sprite Sheet.png" Nothing Nothing
    , Drawer "tops" "Tops" "Sprite Sheet - Tops.png" Nothing Nothing
    , Drawer "tops2" "Tops 2" "extras/Tops.png" Nothing Nothing
    , Drawer "tops3" "Tops 3" "extras2/Tops Sprite Sheet.png" Nothing Nothing
    , Drawer "bottoms" "Bottoms" "Sprite Sheet - Bottoms.png" Nothing Nothing
    , Drawer "bottoms2" "Bottoms 2" "extras/Bottoms.png" Nothing Nothing
    , Drawer "facial-hair" "Facial Hair" "extras/Facial Hair.png" Nothing Nothing
    , Drawer "facial-hair2" "Facial Hair 2" "extras2/Facial Hair Sprite Sheet.png" Nothing Nothing
    , Drawer "shoes" "Shoes" "Sprite Sheet - Shoes.png" Nothing Nothing
    ]
