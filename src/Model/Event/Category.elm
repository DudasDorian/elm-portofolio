module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award

eventCategoryToString : EventCategory -> String
eventCategoryToString category = 
    case category of
        Academic -> "Academic"
        Work -> "Work"
        Project -> "Project"
        Award -> "Award"

eventCategories : List EventCategory
eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = Selected (List EventCategory)


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    Selected eventCategories


{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    let
        (Selected categories) = current
    in

        List.member category categories


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    if value 
        then
            if (isEventCategorySelected category current) then current else (addCategory category current)
        else
            if (not <| isEventCategorySelected category current) then current else (removeCategory category current)

addCategory : EventCategory -> SelectedEventCategories -> SelectedEventCategories
addCategory category current = 
    let
        (Selected categories) = current
        completedList = categories ++ List.singleton category
    in
        (Selected completedList)

removeCategory : EventCategory -> SelectedEventCategories -> SelectedEventCategories
removeCategory category current = 
    let
        (Selected categories) = current
        completedList = List.filter (\x -> x /= category) categories
    in
        (Selected completedList)

checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]

view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    let
        displayCheckboxes = 
            eventCategories
            |> List.map (\x -> checkbox (eventCategoryToString x) (isEventCategorySelected x model) x)
            |> div []
    in
        div [] [
            displayCheckboxes
        ]
