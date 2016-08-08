module Messages exposing (..)

import Models exposing (..)

type Msg
  = Refresh
  | SelectPart String (Float, Float)
  | SelectDrawer Drawer
