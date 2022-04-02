module Model exposing (..)

import Html exposing (b, div, p, text)
import Model.Date as Date
import Model.Event as Event exposing (Event)
import Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, set)
import Model.Interval as Interval
import Model.PersonalDetails exposing (DetailWithName, PersonalDetails)
import Model.Repo exposing (Repo)


type alias Model =
    { personalDetails : PersonalDetails
    , events : List Event
    , selectedEventCategories : SelectedEventCategories
    , repos : List Repo
    }


academicEvents : List Event
academicEvents =
    [ { title = "Academic event 1"
      , interval = Interval.withDurationYears (Date.onlyYear 2016) 4
      , description = p [] [ text "I obtained ", b [] [ text "very" ], text " good grades." ]
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Academic event 2"
      , interval = Interval.withDurationYears (Date.onlyYear 2020) 2
      , description = div [] []
      , category = Academic
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


workEvents : List Event
workEvents =
    [ { title = "Work event 1"
      , interval = Interval.withDurationMonths 2019 Date.Jun 3
      , description = text "Internship"
      , category = Work
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Work event 2"
      , interval = Interval.open (Date.full 2020 Date.Sep)
      , description = text "Junior position"
      , category = Work
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


projectEvens : List Event
projectEvens =
    [ { title = "Personal project 1"
      , interval = Interval.oneYear 2018
      , description = text "Small app in Java"
      , category = Project
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Personal project 2"
      , interval = Interval.oneYear 2020
      , description = text "Command line utility in C"
      , category = Project
      , url = Nothing
      , tags = []
      , important = False
      }
    , { title = "Personal project 3"
      , interval = Interval.oneYear 2020
      , description = text "Movie database for License thesis"
      , category = Project
      , url = Nothing
      , tags = []
      , important = False
      }
    ]


personalDetails : PersonalDetails
personalDetails =
    { name = "Dudas Dorian"
    , intro = "I like computers"
    , contacts = [ DetailWithName "email" "dorian@dudas.ro" ]
    , socials = [ DetailWithName "github" "https://github.com/DudasDorian" ]
    }


initModel : Model
initModel =
    { personalDetails = personalDetails
    , events = Event.sortByInterval <| academicEvents ++ workEvents ++ projectEvens
    , selectedEventCategories = allSelected |> set Academic True
    , repos = []
    }
