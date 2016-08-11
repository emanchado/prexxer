module Models exposing (..)

import Dict exposing (Dict)

import Routing

type alias Dimensions =
  { width : Int
  , height : Int
  }

type alias SquareCoords =
  { x : Int
  , y : Int
  , width : Int
  , height : Int
  }

type alias Drawer =
  { id : String
  , name : String
  , spriteUrl : String
  , dimensions : Maybe Dimensions
  , contentSquare : Maybe SquareCoords
  }

type alias Wardrobe =
  { id : String
  , name : String
  , dollWidth : Int
  , dollHeight : Int
  , spacerWidth : Int
  , spacerHeight : Int
  , drawers : List Drawer
  }

type alias OutfitSelection =
  { drawerCol : Int
  , drawerRow : Int
  }

type alias Model =
  { route : Routing.Route
  , wardrobe : Wardrobe
  , selectedOutfit : Dict String OutfitSelection
  , selectedDrawer : Maybe String
  , dollAsDataURL: String
  }
