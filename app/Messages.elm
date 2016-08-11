module Messages exposing (..)

import Models exposing (..)
import Ports exposing (DrawerContainerInfo)

type Msg
  = SelectPart String (Float, Float)
  | SelectDrawerTab Drawer
  | CalculateDrawerContainer String
  | DrawerContainerResult DrawerContainerInfo
  | PngExportResult String
