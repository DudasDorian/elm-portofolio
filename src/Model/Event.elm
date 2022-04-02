module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)
import Html.Attributes exposing (href)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"

sortByInterval : List Event -> List Event
sortByInterval events =
    List.sortWith (\a -> \b -> Interval.compare a.interval b.interval) events


view : Event -> Html Never
view event =
    let
        listURL : Maybe String -> Html Never
        listURL url =
            case url of
               Nothing -> text ""
               Just s -> p [class "event-url"] [a [href s] [text s]]
    in
        div [classList [("event", True), ("event-important", event.important)]] [
            h3 [class "event-title"] [text event.title]
            , p [class "event-interval"] [Interval.view event.interval]
            , p [class "event-description"] [event.description]
            , p [class "event-category"] [categoryView event.category]
            , listURL event.url
        ]
