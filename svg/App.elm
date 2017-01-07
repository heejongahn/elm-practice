module App exposing (main)

import Html exposing (Html, program, input, div)
import Html.Attributes exposing (id, type_, style, step)
import Html.Events exposing (onInput)

import Svg exposing (svg, circle)
import Svg.Attributes exposing (width, height, viewBox, cx, cy, r)

type alias Model = {
    radius : Float
    }

type Msg
  = ChangeRadius String

main : Program Never Model Msg
main =
  Html.program
    { init = ( { radius = 10 }, Cmd.none )
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ChangeRadius newRadius ->
      let
        rad = String.toFloat newRadius |> Result.withDefault 10
      in
      ( { radius = rad }, Cmd.none )

view : Model -> Html Msg
view { radius } =
  div
    [ id "main" ]
    [ radiusInput, myCircle radius ]

radiusInput : Html Msg
radiusInput =
  input
      [ type_ "range"
      , onInput ChangeRadius
      , step "0.01"
      , style [ ( "display", "block" ) ]
      ] []

myCircle : Float -> Html Msg
myCircle radius =
  let
    rad = toString radius
    doubledRad = toString <| 2 * radius
  in
  svg
    [ width doubledRad, height doubledRad, viewBox <| "0 0 " ++ doubledRad ++ " " ++ doubledRad ]
    [ circle [ cx rad, cy rad, r rad ] [] ]
