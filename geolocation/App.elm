module App exposing (main)

import Html exposing (Html, program, text)
import Task exposing (attempt, perform)
import Geolocation exposing (Location)
import Geolocation

type alias Model = Maybe Location

type Msg
  = SetLocation Location
  | InvalidateLocation

main : Program Never Model Msg
main =
  Html.program
    { init = ( Nothing, attempt handleFetchResult Geolocation.now )
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

handleFetchResult : Result Geolocation.Error Location -> Msg
handleFetchResult result =
  case result of
    Ok location ->
      SetLocation location
    Err e ->
      InvalidateLocation

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SetLocation location ->
      ( Just location, Cmd.none )
    InvalidateLocation ->
      ( Nothing, Cmd.none )

view : Model -> Html Msg
view model =
  case model of
    Nothing ->
      text "현재 위치 알 수 없음"
    Just location ->
      text <| "lat: " ++ (toString location.latitude) ++ ", lon: " ++ (toString location.longitude)
