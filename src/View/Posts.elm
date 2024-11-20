module View.Posts exposing (..)

import Html exposing (Html, div, text, select, option, label, input)
import Html.Attributes exposing (href)
import Html.Events
import Model exposing (Msg(..))
import Model.Post exposing (Post)
import Model.PostsConfig exposing (Change(..), PostsConfig, SortBy(..), filterPosts, sortFromString, sortOptions, sortToCompareFn, sortToString)
import Time exposing (Posix)
import Util.Time


{-| Show posts as a HTML [table](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/table)

Relevant local functions:

  - Util.Time.formatDate
  - Util.Time.formatTime
  - Util.Time.formatDuration (once implemented)
  - Util.Time.durationBetween (once implemented)

Relevant library functions:

  - [Html.table](https://package.elm-lang.org/packages/elm/html/latest/Html#table)
  - [Html.tr](https://package.elm-lang.org/packages/elm/html/latest/Html#tr)
  - [Html.th](https://package.elm-lang.org/packages/elm/html/latest/Html#th)
  - [Html.td](https://package.elm-lang.org/packages/elm/html/latest/Html#td)

-}






postTable : PostsConfig -> Time.Posix -> List Post -> Html Msg
postTable _ _ posts =
    Html.table []
        [ Html.thead []
            [ Html.tr []
                [ Html.th [] [ text "Score" ]
                , Html.th [] [ text "Title" ]
                , Html.th [] [ text "Type" ]
                , Html.th [] [ text "Time" ]
                , Html.th [] [ text "Link" ]
                ]
            ]
        , Html.tbody [] (List.map postRow posts)
        ]

postRow : Post -> Html Msg
postRow post =
    Html.tr []
        [ Html.td [ Html.Attributes.class "post-score" ] [ text (String.fromInt post.score) ]
        , Html.td [ Html.Attributes.class "post-title" ] [ text post.title ]
        , Html.td [ Html.Attributes.class "post-type" ] [ text post.type_ ]
        , Html.td [ Html.Attributes.class "post-time" ] [ text (Util.Time.formatTime Time.utc post.time) ]
        , Html.td [ Html.Attributes.class "post-url" ]
            [ maybeLink post.url ]
        ]

  
maybeLink : Maybe String -> Html Msg
maybeLink maybeUrl =
      case maybeUrl of
          Just url ->
              Html.a [ href url ] [ text "Link" ]
  
          Nothing ->
              text ""


      
    -- TODO: draw rows with posts

  -- div [] []
    -- Debug.todo "postTable"

{-| Show the configuration options for the posts table

Relevant functions:

  - [Html.select](https://package.elm-lang.org/packages/elm/html/latest/Html#select)
  - [Html.option](https://package.elm-lang.org/packages/elm/html/latest/Html#option)
  - [Html.input](https://package.elm-lang.org/packages/elm/html/latest/Html#input)
  - [Html.Attributes.type\_](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#type_)
  - [Html.Attributes.checked](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#checked)
  - [Html.Attributes.selected](https://package.elm-lang.org/packages/elm/html/latest/Html-Attributes#selected)
  - [Html.Events.onCheck](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onCheck)
  - [Html.Events.onInput](https://package.elm-lang.org/packages/elm/html/latest/Html-Events#onInput)

-}
postsConfigView : PostsConfig -> Html Msg
postsConfigView _ =
    div []
        [ -- Number of Posts Select
          div []
              [ label [] [ text "Number of posts per page:" ]
              , select [ Html.Attributes.id "select-posts-per-page" ]
                  [ option [ Html.Attributes.value "10" ] [ text "10" ]
                  , option [ Html.Attributes.value "25" ] [ text "25" ]
                  , option [ Html.Attributes.value "50" ] [ text "50" ]
                  ]
              ]
          -- Sort By Select
        , div []
              [ label [] [ text "Sort posts by:" ]
              , select [ Html.Attributes.id "select-sort-by" ]
                  [ option [ Html.Attributes.value "score" ] [ text "Score" ]
                  , option [ Html.Attributes.value "title" ] [ text "Title" ]
                  , option [ Html.Attributes.value "date" ] [ text "Date Posted" ]
                  , option [ Html.Attributes.value "unsorted" ] [ text "Unsorted" ]
                  ]
              ]
          -- Show Job Posts Checkbox
        , div []
              [ label []
                  [ input
                      [ Html.Attributes.type_ "checkbox"
                      , Html.Attributes.id "checkbox-show-job-posts"
                      ]
                      []
                  , text " Show job posts"
                  ]
              ]
          -- Show Text-Only Posts Checkbox
        , div []
              [ label []
                  [ input
                      [ Html.Attributes.type_ "checkbox"
                      , Html.Attributes.id "checkbox-show-text-only-posts"
                      ]
                      []
                  , text " Show text-only posts"
                  ]
              ]
        ]
