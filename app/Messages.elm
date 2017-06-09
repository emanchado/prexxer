module Messages exposing (..)

import Navigation
import Models exposing (..)
import Ports exposing (DrawerContainerInfo)


type Msg
    = UpdateLocation Navigation.Location
    | SelectPart String (Int, Int)
    | SelectDrawerTab Drawer
    | CalculateDrawerContainer String
    | DrawerContainerResult DrawerContainerInfo
    | PngExportResult String
