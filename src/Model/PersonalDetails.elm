module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }

view : PersonalDetails -> Html msg
view details =
    let
        contactsUnwrap =
            details.contacts
            |> List.map (\x -> p [] [text <| x.name ++ " : " ++ x.detail])
            |> div [class "contact-detail"]
        socialsUnwrap = 
            details.socials
            |> List.map (\x -> p [] [a [href x.detail] [text <| x.name ++ " : " ++ x.detail]])
            |> div [class "social-link"]
    in
        div [] [
            h1 [id "name"] [text details.name]
            , p [] [em [id "intro"] [text details.intro]]
            , contactsUnwrap
            , socialsUnwrap
        ]
