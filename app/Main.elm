import Navigation
import Dict
import List

import Routing
import Messages exposing (..)
import Models exposing (Model, OutfitSelection)
import Views
import Update
import Wardrobes exposing (initialWardrobe)
import Ports exposing (redrawDoll, redrawEvent, foundDrawerContainer, pngExportResponse)

main : Program Never
main =
  Navigation.program Routing.parser
    { init = init
    , view = Views.mainApplicationView
    , update = Update.update
    , urlUpdate = Update.urlUpdate
    , subscriptions = subscriptions
    }

init : Result String Routing.Route -> (Model, Cmd Msg)
init result =
  let
    route = Routing.routeFromResult result
    model =
      Model
        route
        initialWardrobe
        (Dict.fromList [])
        (case List.head initialWardrobe.drawers of
           Just drawer -> Just drawer.id
           Nothing -> Nothing)
        "data:image/png;base64,"
  in
    (model, redrawDoll (redrawEvent model))

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
    [ foundDrawerContainer SetDrawerContainer
    , pngExportResponse PngExportResult
    ]
