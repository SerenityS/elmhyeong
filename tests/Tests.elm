-- Generated by /test-macro.js
module Tests exposing (all)

import Test exposing (describe, test, Test)
import Expect
import Parser exposing (parse)
import Lexer exposing (showCommandPrefix)
import List

t label problem answer = test label <| \() ->
    Expect.equal [answer] (List.map showCommandPrefix (parse problem))

all : Test
all = describe "test" [syntax]

syntax : Test
syntax = describe "syntax"
    [ describe "한글 해석"
        [ t "형 should be 형 1 0" "형" "형 1 0"
        , t "항 should be 항 1 0" "항" "항 1 0"
        , t "핫 should be 핫 1 0" "핫" "핫 1 0"
        , t "흣 should be 흣 1 0" "흣" "흣 1 0"
        , t "흡 should be 흡 1 0" "흡" "흡 1 0"
        , t "흑 should be 흑 1 0" "흑" "흑 1 0"
        , t "혀엉 should be 형 2 0" "혀엉" "형 2 0"
        , t "하앙 should be 항 2 0" "하앙" "항 2 0"
        , t "하앗 should be 핫 2 0" "하앗" "핫 2 0"
        , t "흐읏 should be 흣 2 0" "흐읏" "흣 2 0"
        , t "흐읍 should be 흡 2 0" "흐읍" "흡 2 0"
        , t "흐윽 should be 흑 2 0" "흐윽" "흑 2 0"
        , t "흐...읍 should be 흡 2 0" "흐...읍" "흡 2 0"
        , t "혀일이삼사오육앙앗읏읍엉 should be 형 12 0" "혀일이삼사오육앙앗읏읍엉" "형 12 0"
        , t "혀일....이삼사오육앙♥앗?!읏♡읍...엉 should be 형 12 0" "혀일....이삼사오육앙♥앗?!읏♡읍...엉" "형 12 0"
        , t "흐일이삼사 오육앙하앗읏읍엉 should be 흣 11 0" "흐일이삼사 오육앙하앗읏읍엉" "흣 11 0"
        , t "하흐읏앗앙 should be 핫 4 0" "하흐읏앗앙" "핫 4 0"
        , t "혀흐하윽 should be 흑 3 0" "혀흐하윽" "흑 3 0"
        ]
    , describe "말줄임표 해석"
        [ t "혀엉.... should be 형 2 4" "혀엉...." "형 2 4"
        , t "하앗. … ⋯ ⋮ should be 핫 2 10" "하앗. … ⋯ ⋮" "핫 2 10"
        , t "혀읏......잠....하앙....혀엉. ..... should be 형 7 6" "혀읏......잠....하앙....혀엉. ....." "형 7 6"
        ]
    , describe "하트 구역 해석"
        [ t "하앗....♥♡! should be 핫 2 4 !♥_" "하앗....♥♡!" "핫 2 4 !♥_"
        , t "하아앗.. . ? ♥ ! 💖 should be 핫 3 3 ?_!♥💖" "하아앗.. . ? ♥ ! 💖" "핫 3 3 ?_!♥💖"
        , t "혀엉...♥?!♡ should be 형 2 3 ?♥!_♡" "혀엉...♥?!♡" "형 2 3 ?♥!_♡"
        ]
    ]
