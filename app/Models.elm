module Models exposing (..)

import Dict exposing (Dict)

import Routing

type alias Drawer =
  { id : String
  , spriteUrl : String
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
  }
