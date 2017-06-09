module Main exposing (..)

import Navigation
import Dict
import List
import Routing
import Messages exposing (..)
import Models exposing (Model)
import Views
import Update
import Wardrobes exposing (initialWardrobe)
import Ports exposing (redrawDoll, redrawEvent, drawerContainerResponder, pngExportResponder)


main : Program Never Model Msg
main =
    Navigation.program UpdateLocation
        { init = init
        , update = Update.update
        , subscriptions = subscriptions
        , view = Views.mainApplicationView
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
  let
    model = { route = Routing.parseLocation location
            , wardrobe = initialWardrobe
            , selectedOutfit = (Dict.fromList [])
            , selectedDrawer = (case List.head initialWardrobe.drawers of
                                  Just drawer -> Just drawer.id
                                  Nothing -> Nothing)
            , dollAsDataURL = "data:image/png;base64,"
            }
  in
    ( model
    , redrawDoll (redrawEvent "final-doll" model)
    )


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ drawerContainerResponder DrawerContainerResult
            , pngExportResponder PngExportResult
            ]
