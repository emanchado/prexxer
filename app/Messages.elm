module Messages exposing (..)

import Models exposing (..)
import Ports exposing (DrawerContainerResponse)

type Msg
  = SelectPart String (Float, Float)
  | SelectDrawer Drawer
  | CalculateContentSquare String
  | SetDrawerContainer DrawerContainerResponse
  | PngExportResult String
