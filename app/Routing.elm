module Routing exposing (..)

import Navigation
import UrlParser exposing (..)


type Route
    = Index
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map Index (s "")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
  case (parsePath matchers location) of
    Just route -> route
    Nothing -> NotFoundRoute


routeFromResult : Result String Route -> Route
routeFromResult result =
    case result of
        Ok route ->
            route

        Err string ->
            NotFoundRoute
