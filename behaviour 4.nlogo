extensions [gis csv]
breed [countries country]
directed-link-breed [redlinks redlink]
directed-link-breed [greenlinks greenlink]
directed-link-breed [blacklinks blacklink]
undirected-link-breed [unionlinks unionlink]
undirected-link-breed [ununionlinks ununionlink]


countries-own
[

  c  ;confidence-level a2
  m  ;名声  a3 reputation
  last-c
  last-m
  member-set
  code
 international-effect  ;;e  ,a1
  last-international-effect
  initial-ie
  es ;; economic strength
  initial-es
  last-es
 es-change-rate
  nr ;;natural resources
  last-nr

  ms  ;;military strength
  last-ms



  ts  ;; technological strength
  ts-change-rate
  initial-ts
  last-ts

  pn ;; population
  pn-change-rate
  initial-pn
  last-pn


state;; 状态 如果到了忍耐k2之下会进入忍耐状态并不会被选中进行背叛
pm;;人口满意度





  cl;;文化类型

  political-system ;;政治体系
  second-cl ;;第二文化


  i;;贸易依存度


  ts-ratio


  coop-member
  coop-with-high-member
 ; group-member



  neighbor-list ;;附近的国家
  neighbour ;;接壤的国家
  betray-member ;;背叛的记忆



  strategy
  s-type
  s-type-last-1
  s-type-last-2
  s-type-payoff-1
  s-type-payoff-2

  o;overconfidence-level



  payoff
  virtual-payoff;;loss aversion

  type-pool-be
  type-pool-coop
  type-pool-hold
  type-pool-tit
  type-pool-gtit
  type-pool-current

  tb-counter
  tb-s-counter
  tb-steps
  tc-counter
   tc-s-counter
  tc-steps
  th-counter
   th-s-counter
  th-steps
  tt-counter
   tt-s-counter
  tt-steps
  tg-counter
   tg-s-counter
  tg-steps

  own-max-type
  own-max-item

  random-prob



  interaction-list



   ba  ;;b1
  bb  ;;b2
   bc  ;;b3
  bd ;;b4
  be ;;b5


    group-id
group-state
  group-member

  currecy-type;;

  credit


 primary
 secondary
  third
  structure


 ma;;mind account
  irrational-type;;
  irrational
  la;;loss avrrsion

]



links-own
[
green-link-time
red-link-time
]



globals
[
  countries-dataset
  csv-data-list
  total-sum-es





  change-rate
  change-rate-rational
  change-rate-over-confidence
  change-rate-loss-aversion
  change-rate-ts


  sum-es-last
  sum-over-confidence-last
  sum-loss-aversion-last
  sum-rational-last
  sum-ts-last



  differ-es
  last-sum-es
  time
  counter
  counter-hies
  culture-prob
  cl-betray-prob
  cl-coop-prob
  group-prob
neighbor-prob ;;邻居的影响概率
  neighbour-prob
  diff-ps-prob;; 不同政治体系下的影响
  same-cl-prob ;;同等文化下的互相影响
  distance-of-countries



  sum-all-es
  sum-over-confidence
  sum-loss-aversion
  sum-rational
  sum-all-ts




hie-members
  hie-member
  groups-list
  es-p
  group-state-influence
  history-influence


  type-coop
  type-be
  type-hold
  type-tit
  type-gtit


  type-score
  max-type
  max-item


  all-be-counter
  all-coop-counter
  all-hold-counter
  all-tit-counter
  all-gtit-counter



  g-number


  shock-prob


  coop-number
  i-number
  coop-rate
  average-coop-rate

  be-members
  coop-members
  hold-members
  tit-members
  gtit-members
  distance-xy




  stt;;stress-test
  stt-state;; on or off
  stt-time;;time

  v2-time

  v3-time

  be-pro



  average-betray-rate
  betray-rate
  betray-pool

  jump-point





 shock-state



  shock-data;;strat-data
  shock-data-1;;time-1
  shock-data-2 ;;time-2
  shock-data-3;time-3
  shock-time ;check-time
  shocked?
  change-percentage1 ;;check if detactive shock
  change-percentage2
  change-percentage3
  change-percentage
  trending-time ;;growing
  holdig-time ;;droppinng
  gdp-para



  in-shock-time
  off-shock-time

lock-shock

  lockshocked?
  lockshocked-para


  count-be
  count-coop
  count-hold
  count-tit
  count-gtit



currency
  USD ;;swift
  CNY ;;cipc
  EUR ;;instex
  JPY
   GBP
  CAN
  AUS



  s-prob;;structure prob

  s-list
  s-list-h

]





to setup
  clear-all
  set stt-state "off"
  set total-sum-es []
  set differ-es 0
  set last-sum-es 0
  set hie-members []
  set-default-shape redlinks "curve"
  set-default-shape greenlinks "curve"
  set-default-shape blacklinks "curve"

  set shocked? "no"
  set time 0
  ask patches [set pcolor white]
  set same-cl-prob 1
  set diff-ps-prob 1
  load-gis-data
  load-csv-data
  choose-show-country
  setup-last-value
  set all-be-counter 0
 set  all-coop-counter 0
  set all-hold-counter 0
  set same-cl-prob 1
  set g-number precision random 3 1
 ; set sum-es-last sum [es] of countries
  set sum-ts-last sum [ts] of countries
  set sum-all-ts sum [ts] of countries
  set coop-number 0
  set i-number 0
  set coop-rate coop-number / (i-number + 1)
  set be-members []
  set coop-members []
  set hold-members []
  set tit-members []
  set gtit-members []
  set shock-state 0
  set average-coop-rate 0
   set shock-data sum [es] of countries
  set shock-time time
  set s-list []
  set s-list-h []
  reset-ticks
end

to setup-last-value
  ask countries
  [
 set  last-c c
 set last-m m

 set last-international-effect    international-effect
 set last-es es
 set last-nr nr
 set last-ms ms
 set   last-ts ts
 set last-pn pn
        set last-sum-es sum [international-effect] of countries
  ]

  ask countries with [international-effect > n]
  [
   ;; print code
   ;; print neighbor-list

  ]
end





to choose-show-country
  ask  max-n-of choose-countries-total-number  countries [international-effect ]
  [
   set hidden? false
   if international-effect > n
    [
     set color red
    ]

  ]


  ask  countries with [hidden? = true]
  [die]

 ; show count countries with [international-effect > n ]

end


to load-csv-data
  set csv-data-list csv:from-file  "data/data_mergy.csv"

  foreach csv-data-list
  [
    data-item-list ->
    ask countries with [code = item 1 data-item-list  ]
      [
         set m  0
        set es item  10 data-item-list


        set  initial-es es
        set nr item 7  data-item-list
        if nr = 0
        [
          set nr 0.001
        ]
        set ms item 8 data-item-list
        if ms = 0
          [
         set ms 0.001
        ]
        set ts item 9 data-item-list
        if ts = 0
        [
         set ts 0.001
        ]
        set   pn item 11 data-item-list
        if   pn = 0
        [set pn  0.001]
        set initial-pn pn
       ;; set cu item
        set cl item 12 data-item-list
         if cl = ""
        [

         set cl 0
        ]
        set political-system item 14 data-item-list
        set i item 15 data-item-list
        if i  = 0
        [
          set i 50


        ]
        set primary item 17 data-item-list
        set primary primary / 100
        set secondary item 18 data-item-list
        set secondary secondary / 100
        set third item 19 data-item-list
        set third  third / 100
        set i i / 100
        set second-cl item 13 data-item-list
        if second-cl = ""
        [

         set second-cl 0
        ]
        if cl = 9 ;;india
        [
           set c precision (0.5001 + random-float 0.3)4


        ]
        if cl = 7 ;;colonialist culture
        [
         set c precision (0.6001 + random-float 0.3)4

        ]
        if cl = 8
        [
         set c precision (0.2001 + random-float 0.3)4

        ]
        if cl = 1 ;;Confucius Culture in East Asia
        [
         set c precision (0.0001 + random-float 0.3)4
        ]

        if cl = 5 ;;European culture
        [
         set c precision ( 0.3001 + random-float 0.4)4
        ]

        if cl = 6 　;;Islamic culture
        [
         set c precision (0.4001 + random-float 0.4)4
        ]

        if cl = 2 ;;Southeast Asian Buddhist culture
        [
         set c precision (0.1001 + random-float 0.4)4
        ]

        if cl = 4 ;;Byzantine culture
        [
         set c precision (0.2001 + random-float 0.4)4
        ]

        if cl = 3 ;;African culture
        [
         set c precision (0.2001 + random-float 0.3)4

        ]
        if cl = ""
        [
          set c precision (0.001 + random-float 0.2)4

        ]
        set   international-effect ( b1 * es + b2  * ms + b3 * nr + b4 * ts + b5 * pn)
      ;  show international-effect
        set last-international-effect   international-effect
if es = 0
        [

         set es 0.001
        ]
         set initial-es es
        set initial-ts ts
        set ts-change-rate 0
        set group-id code
        set group-member []
        set coop-member []
        set coop-with-high-member []

         set  neighbor-list [code] of countries in-radius 15
        set  neighbour [code] of countries in-radius 5
        set state "close"
        set group-state []
        set  pm 0
        set betray-member []

        set ts-ratio ts / (es + 1)
        set strategy []
        set s-type "coop"

       set  type-pool-be 0
  set type-pool-coop 0
  set type-pool-hold 0
  set type-pool-tit 0
        set type-pool-gtit 0

     set    tb-counter 0
  set tc-counter 0
 set  th-counter 0
        set tt-counter 0
        set tg-counter 0


        set random-prob precision  random-float 1 3

        set  interaction-list []


set   ba   b1;;b1
  set bb  b2;;b2
 set   bc  b3;;b3
 set  bd b4 ;;b4
set   be b5
        ifelse international-effect > n
        [
       set  irrational-type "irrational"

          set irrational "loss-aversion"
;set irrational  "loss-aversion"
        set o random-float 1
ifelse irrational = "loss-aversion"
        [
        set la random-exponential 2
        if la <= 1
        [
         set la 1.1

        ]
        ]
        [
         set la 1

        ]
        ]
        [
         set   irrational-type "rational"
        ]
       ; set  irrational-type  "irrational"

        set structure ( 3 * primary + 2 * secondary + 1 * third)

    ]


  ]


end


to record-members

 if time  = 1119
 [
    set  be-members [code] of countries with [s-type = "be"]
 set  coop-members [code] of countries with [s-type = "coop"]
  set hold-members [code] of countries with [s-type = "hold"]
 set  tit-members [code] of countries with [s-type = "tit"]
 set   gtit-members [code] of countries with [s-type = "gtit"]



  ]




end


to load-gis-data



  gis:load-coordinate-system (word "data/countries.prj")
  ; Load all of our datasets

  set countries-dataset gis:load-dataset "data/countries.shp"

  gis:set-world-envelope (gis:envelope-union-of  (gis:envelope-of countries-dataset))

  gis:set-drawing-color blue
  gis:draw countries-dataset 1.2
 foreach gis:feature-list-of countries-dataset
    [
        ? ->
        let centroid gis:location-of gis:centroid-of ?

      if not empty? centroid
      [ create-countries 1
        [ set xcor item 0 centroid
          set ycor item 1 centroid
          set size 2
          set shape "circle"
          set color blue

            set hidden? true
          set code gis:property-value ? "GMI_CNTRY"
  ] ] ]
end


to go-1000

   set emergency-p emergency-p + 0.1
    if emergency-p >= 0.7[
      set emergency-p 0
    set p-betray p-betray + 0.1
     if p-betray >= 0.7
  [
   set p-betray 0
   set p-coo p-coo + 0.1
      if p-coo >= 0.7
      [
          set p-coo 0
      stop

      ]

      ]
  ]



end


to stress-test

  if stt <= 0.03
  [

   set stt-state "on"


set stt-time time
  ]



  ;if stt-state-switch




end

to stress-test-v2 ;;individual countries


  if time = shock-time + 1
  [
    set shock-data-1 sum [es] of countries
    set change-percentage1 ((shock-data-1 - shock-data) / shock-data) * 100
    set change-percentage change-percentage + change-percentage1
  ]
  if time = shock-time + 2
  [
    set shock-data-2 sum [es] of countries
     set change-percentage2 ((shock-data-2 - shock-data) / shock-data) * 100
    set change-percentage change-percentage + change-percentage2
  ]
  if time  = shock-time + 3
  [
    set shock-data-3 sum [es] of countries
     set change-percentage3 ((shock-data-3 - shock-data) / shock-data) * 100
    set change-percentage change-percentage + change-percentage3
  ]
  if time  = shock-time + 4
  [
    set shock-time time
    set shock-data sum [es] of countries
    set change-percentage 0
  ]


  ifelse change-percentage < -0.5
  [
   set shocked? "yes"
    set gdp-para 0.5
    set v2-time time
  ]
[
    set shocked? "no"
    set gdp-para 0
  ]
end



to stress-test-v3
  ifelse lock-shock < 0.05
  [

    set lockshocked? "yes"
    set  lockshocked-para 0.5
    set v3-time time

  ]
  [
    set lockshocked? "no"
    set  lockshocked-para 0
  ]

end
to be-in-the-union


 ask countries
 [
   let id code
      let ee-low international-effect
      let  es1 es
      let m-low m
      let c-low c
    let cl1 cl
let pm-low pm
    let ps1 political-system
    let neighbour1  neighbour
      let neighbor neighbor-list
let cm1 coop-member
   let gm1 group-member
    ;;print code
   ;; print neighbor

    let new-union-agent  other countries with [member? code cm1] with [international-effect > n]
      ask new-union-agent
    [
      let id2 code

        let ee-high international-effect
        let es2 es
        let m-high m
        let c-high c
        let pm-high pm
         let cl2 cl
      let ps2 political-system
      let cm2 coop-member
      let gm2 group-member
     ;; print es1 / es2
if ps1 = "so"
      [
        if ps2 = "cp"
        [
          set diff-ps-prob 0
        ]
      ]
    if cl1 = cl2 = 6
      [
       set same-cl-prob 0.4
      ]

    if cl1 = cl2 = 5
      [
       set same-cl-prob 1.5
      ]
if (( cl1 = 1 ) and  (cl2 = 7)) or ((cl1 = 7) and (cl2 = 1))
      [
       set same-cl-prob 0.3
      ]
      if member? id2 neighbor
      [
        if member? id2 neighbour
        [
          set neighbor-prob 1.05
        ]

          set neighbor-prob 1.1

      ]
      let cooperation-p (( ( es1 - es2 ) * hl1 +  (m-high + m-low) * hl2  + (pm-high + pm-low) * hl3))  * same-cl-prob * neighbor-prob * diff-ps-prob
     ;print id
    ;  print id2
    ;  print cooperation-p

      if cooperation-p > (1 - coop-rate)
      [



      ;  create-links-with countries with [code = id][set color orange]
        set gm1 lput id2 gm1
        set gm2 lput id gm2
        set group-member gm2



      ]
    ]
    set group-member gm1
  ]


  ask countries
  [
    let gi group-id
    let gm group-member
    let ee international-effect
    let code1 code
    let others countries with [member?  code gm]
    ask others
    [
      let gi2 group-id
      let gm2 group-member
      let ee2 international-effect
      let code2 code
      ifelse ee2 > ee
      [
       set gi code2
       set gi2 code2

      ]
      [
       set gi code1
       set gi2 code1
      ]
      set group-id gi2

    ]

    set group-id gi

  ]
end
to go-1
  set p-betray p-betray + 0.1

     if p-betray >= 1
  [
   set p-betray 0

  ]

end


to  go

if time > 1200
  [
   ; go-1
    if sum [es] of countries > 600
    [
      setup
      reset-perspective
    ; stop
    ]

  setup
  reset-perspective
  ;  stop
  ]
  ask countries
  [
   set last-es es

  ]

  set stt random-exponential 1
 ;; print stt
  set shock-prob random-exponential 0.01
set lock-shock random-exponential 5
  set sum-es-last sum [es] of countries
  set sum-loss-aversion-last sum [es] of countries with [irrational = "loss-aversion"]
  set sum-over-confidence-last sum [es] of countries with [irrational = "over-confidence"]
  set sum-rational-last sum [es] of countries with [irrational-type = "rational"]
  setup-last-value
  ;;stress-test
;; stress-test-v2
;; stress-test-v3

    betray-first-step
 ; betray-following
betray
  be-in-the-union
  caculate
    ask countries
  [
    if payoff < 0
    [

     set payoff payoff * la


    ]

      set s-type-last-2  s-type-last-1
    set s-type-payoff-2  s-type-payoff-1
    set  s-type-last-1 s-type
     set s-type-payoff-1 payoff
     set random-prob precision  random-float 1 3
   set own-max-type item 0  sort-by > (list (type-pool-coop) (type-pool-be) (type-pool-hold) (type-pool-tit)(type-pool-gtit))


    if own-max-type = type-pool-coop
 [

     set own-max-item "coop"
  ]
if own-max-type = type-pool-be
 [

     set own-max-item "be"
  ]
if own-max-type = type-pool-hold
 [

     set own-max-item "hold"
  ]
if own-max-type = type-pool-tit
 [

     set own-max-item "tit"
  ]
if own-max-type = type-pool-gtit
 [

     set own-max-item "gtit"
  ]

  ]

  s-steps
   learn-v4

  ;;coop-with-high
;; cooperate
 ; shock

  score-pool
 ; self-evo
 ; adjust-self
 ; learn-all
  record-members
  sure-list
 ; choose-to-coo
 ;; state-change
 ;; break-out-union
 ;; get-in-union
 ;; move-along-in-the-group
 ;; update-papr
 ;; update-m-and-c-by-international-effect
  reset-turtles-color
  sum-up
  record-global-data
 record-global-data-v1
 record-global-data-v2
    if sum [es] of countries > 600
    [
       setup
   reset-perspective
  ]
  ifelse  stt-time + 10 >= time
  [
    set coop-rate random 0.3
    set shock-state 0.5

  ]
  [

   set stt-state "off"
    set coop-rate coop-number / (i-number + 1)

    set shock-state 0
  ]

  set last-sum-es sum [international-effect] of countries
  ask countries
  [

  set coop-member   remove-duplicates coop-member
  set group-member remove-duplicates group-member
    set strategy []
   set es-change-rate (( es - initial-es ) / (initial-es + 1)) * 100
     if es-change-rate >= 0
    [
      set ts ts * (1 + ln ((es-change-rate / 10000) + 1))

    ]

    if es-change-rate < 0
    [

       set ts ts * (1 + ln ((es-change-rate / 10000) + 1))
    ]
 set international-effect ( ba * es + bb  * ms + bc * nr + bd * ts + be * pn)
set ts-ratio ts / international-effect
 set  ts-change-rate ((ts - initial-ts) / (initial-ts + 1)) * 100

    set es-change-rate (es - last-es) / (es + 0.0001)
    let s1 structure
    let others other countries
    ask others
    [
     let s2 structure
      set s-list lput abs(s1 - s2) s-list
      set s-list-h mean s-list

    ]
  ]

;;  plot [es] of countries with [who = "110"]
  ;;print [who] of countries with [code = "ARE"]
  set time time + 1
  set g-number precision  random-float 1 3
  set be-pro  count countries with [s-type = "be"] / count countries
  ;set i-number 0
 ; set coop-number 0
   set average-coop-rate (average-coop-rate + coop-rate) / (time + 0.0000001)
  set  betray-rate count countries with [s-type = "be"] / count countries
  set betray-pool betray-pool + betray-rate
  set average-betray-rate betray-pool / time
  set jump-point 0
   set same-cl-prob 1

if time  = 300
  [
   ask countries
   [

     set s-type "hold"
    ]

  ]



   update-plots
  set s-list []
  set USD 0
  set GBP 0
  set CNY 0
  set EUR 0
  set JPY 0
  set AUS 0
  set CAN 0
  set currency 0

end

to culture-probability

if culture-prob >= 10
[
  set cl-betray-prob 1.5
  ]

  if culture-prob < 10 and culture-prob >= 7
  [
   set cl-betray-prob 1.2
  ]
if culture-prob < 7
  [

   set  cl-betray-prob 0.8
  ]
  if culture-prob >= 8
  [
   set cl-coop-prob 0.9
  ]

  if culture-prob < 8
  [
    set cl-coop-prob 1.3
  ]

end




to break-out-union

ask countries
[
    let code2 code
  let bm1 betray-member

    ask countries with [member? code group-member]
    [
      if member? code bm1
      [
        let code1 code
       ;; create-ununionlinks-with  countries with [code = code2][set color blue]


      ]


    ]



  ]

end

to sure-list



  ask countries
  [
    let id1 code
    let cm1 coop-member
    let bm1 betray-member
   let others other countries
    ask others
    [
      let id2 code
      if  member? id2 bm1
      [

       set cm1 remove id2 cm1

      ]




    ]

     set coop-member cm1
      set betray-member bm1


  ]
end

to get-in-union

  ask countries
  [
    let cl1 cl
    let ie1 international-effect
    let code1 code
    let group-member1 group-member
    let scl1 second-cl
    let coop-member1 coop-member
    let union countries with [member? code coop-member1 = true]
    ask union
    [
      let cl2 cl
      let code2 code
      let group-member2 group-member
      let scl2 second-cl
      let ie2 international-effect
      if ie1 > n
      [
        if cl1 = cl2
        [
          set group-member2 lput code1 group-member2
          set group-member1 lput code2 group-member1
          ;;create-unionlinks-with countries with [code = code1][set color black]
        ]
        if cl1 = scl2
        [
          set group-member2 lput code1 group-member2
          set group-member1 lput code2 group-member1
         ;; create-unionlinks-with countries with [code = code1][set color orange]
        ]
      ]
      if ie1 < n
      [
      if cl1 = cl2
      [
        set group-member1 lput code2 group-member1
        set group-member2 lput code1 group-member2
        ;; create-unionlinks-with countries with [code = code1][set color black]
      ]
      ]
    set group-member group-member2
    ]

    set group-member group-member1
  ]






end


to move-along-in-the-group


   ask  countries
    [
      let id code
      let pn-self pn
      let es-self es
     let neighbor countries with [member? code  neighbour = true]
     let move-to-agent neighbor with [member? code group-member = true]

      ask move-to-agent
      [

        let id1 code
        let es-n es
        let pn-n pn
        if es-n > es-self
        [
          create-blacklinks-from countries with [code = id]
          set pn-self pn-self  *  (1 - (ln(es-n / es-self) / 1000))
          set pn-n pn-n + (ln(es-n / es-self) / 1000)

        ]
       set pn pn-n
      ]
      set pn pn-self
  ]


end


to update-m-and-c-by-international-effect


    ask countries
    [
      if international-effect < last-international-effect
      [
        set  c  c + c * (last-es - es)  /  (last-international-effect - international-effect )
      ]
      if international-effect > last-international-effect
      [

        set  c  c - c * abs((last-es - es)  /  (last-international-effect - international-effect ))

      ]

    set pm pm * (1 + ln ((es - last-es) / last-es + 1))
    if c >= 1
    [
     set c  0.99
    ]
    if c <= 0
    [
      set c 0.01
    ]
     if m <= -1
  [

   set m -0.99
  ]
  if m >= 1
 [
   set m 0.99
  ]
   if pm <= -1
  [
  set pm -0.99
  ]
  if pm >= 1
 [
   set pm 0.99
  ]
    ]
end


to self-evo

ask countries
  [
   ; print es
    set es es + ln((es / pn) ^ ba + (ts / pn) ^ bd + 0.00001)
;print es

  ]








end


to adjust-self ;the porpotion  of ts will chamge due to the payoff of interactions

  ask countries
  [




  ]





end


to betray-first-step

  if time <= 1
  [
ask countries with [international-effect > n ]
  [
    let ee international-effect
    let e1 es
    let m1 m
    let c1 c
    let cl1 cl ;;culture-type
    let pm1 pm
    let choose-begray-agent  other countries ;with [international-effect > n]
    let id code
    let neighbor neighbor-list
    let neighbour-list neighbour
    let group-state-betray group-state
    let ts1 ts
    let scl1 second-cl
    let ps political-system
    let sc1 strategy
    let st1 s-type
    let poff1 payoff
      let bm1 betray-member
      let cm1 coop-member
      let  vp1 virtual-payoff
let i1 i
;;print id
  ask choose-begray-agent
    [

      let id2 code
     ;; print id2
      let ee2 international-effect
      let e2 es
      let m2 m
      let c2 c
      let cl2 cl ;;culture-type
        let pm2 pm
        let ts2 ts
        let ps2 political-system
        let group-state-be-betray group-state
        let scl2 second-cl
        let bm2 betray-member
          let cm2 coop-member
         let sc2 strategy
        let st2 s-type
        let poff2 payoff
        let i2 i
        let  vp2 virtual-payoff

      set culture-prob cl1 + cl2

;;print culture-prob
      culture-probability
;;print ln(e1 / e2 )

      ifelse ps != ps2
        [
        set diff-ps-prob 1.3
        ]
          [
           set diff-ps-prob 1
          ]


        if cl1 = cl2 = 7
        [
          set same-cl-prob 0
        ]
   if cl1 = cl2 = 6 ;;穆斯林国家互相合作的概率会低很多 Islamic culture
      [
       set same-cl-prob 1.5
      ]
      if cl1 = cl2 = 5 ;;european countries合作概率会比一般的要高
      [
       set same-cl-prob 0.7
      ]
        if group-state-be-betray = "grouped"
        [
        ;;  set  group-state-influence
        ]
        if  member? id neighbor
        [
          set neighbor-prob 0.8
        ]
        if member? id neighbour-list
        [
          set neighbour-prob 1.5
        ]
        ;;print id2
        let betray-probability (a1 * (ee - ee2) + abs a2 * (m1 - m2) + abs a3 * (c1 - c2) ) * cl-betray-prob * same-cl-prob * neighbor-prob * neighbour-prob * diff-ps-prob
     ;show betray-probability
;print id
       ; print id2
  if st1 = "be"
      [
       set sc1 "be"

       if st2 = "be"
      [
       set sc2 "be"
            set sc2 "be"
                ;  create-redlinks-from countries with [code = id][set color red]

           set e1  e1 * (1 -  (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 - e1 * ( i1 * a7 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2  poff2 - e2 *  (i2 *  a7 * ln(e1 / e2 + 1))
          set es  e2
            set payoff poff2
                        ;;  print poff1
                         ;; print poff2
  set bm2 lput id bm2
              set betray-member bm2
              set bm1 lput id2 bm1

          set i-number i-number + 2
        ]

        if (st2 = "coop") or (st2 = "tit") or (st2 = "gtit")

        [

             set sc2 "coop"
                   ; create-greenlinks-to countries with [code = id2][set color green]
           ; create-greenlinks-from countries with [code = id][set color green]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 ) + 1))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
         set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2  poff2 - e2 *  (i2 * a6 * ln(e1 / e2 + 1))
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2
  set bm2 lput id bm2


              set betray-member bm2
          set i-number i-number + 2
          set coop-number coop-number + 1

        ]

        if st2 = "hold"
        [
          set sc2  "hold"
       ;   create-redlinks-from countries with [code = id][set color gray]
            set e2  e2 * (1 - (i2 * a5 * ln(e1 / e2 + 1)))
            set poff2 poff2 + e2 * (i2 * (- a5) * ln(e1 / e2 + 1))
            set payoff poff2
            set es  e2
                        ;  print poff2
             set bm2 lput id bm2
              set betray-member bm2
       set poff1 0
          set i-number i-number + 2


      ]


      if (st1 = "coop") or (st1 = "tit") or (st1 = "gtit")
        [
          set sc1 "coop"
          if st2 = "be"
          [
             ; create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + ( i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2  poff2 + e2 *  (i2 * a9 * ln(e1 / e2 + 1))
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1
          ]

          if (st2 = "coop")  or (st2 = "tit") or (st2 = "gtit")
          [
           set sc2 "coop"
           ; create-greenlinks-from countries with [code = id] [set color green]
               ;create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
              set cm1 lput id2 cm1
              set cm2 lput id cm2
               set coop-member cm2
              set es e2

              set payoff poff2
            set i-number i-number + 2
            set coop-number coop-number + 2

          ]

          if st2 = "hold"
          [
            set sc2 "hold"
               ;create-redlinks-from countries with [code = id][set color gray]

                set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
              set e1  e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i1 * (- a4) * ln(e1 / e2 + 1))
              set poff1 poff1 + e1 * (i1 * (- a4) * ln(e1 / e2 + 1))
             set payoff poff2
            set i-number i-number + 2
            set coop-number coop-number + 1
          ]


        ]

         if st1 = "hold"

           [
             set sc1 "hold"


                 if (st2  = "coop") or (st2 = "tit") or (st2 = "gtit")
            [
              set sc2 "coop"
            ; create-redlinks-from countries with [code = id][set color gray]
             set e1  e1 * (1 - (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 +  e1 * ( - a5 * ln(e1 / e2 + 1) * i2)
              set poff2 0
              set es e2
              set payoff poff2
        set i-number i-number + 2
        set coop-number coop-number + 1

            ]
            if st2 = "hold"
            [
              set sc2 "hold"
              set e1 e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
              set e2 e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
              ; create-redlinks-from countries with [code = id][set color gray]
               ; create-redlinks-to countries with [code = id][set color gray]
              set poff1 poff1 + e1 * ( - a5 * ln(e1 / e2 + 1) * i1)
              set payoff payoff + e2 * ( - a5 * ln(e1 / e2 + 1) * i2)
        set i-number i-number + 2
            ]
         if st2 = "be"
          [
           set  sc2 "betray"
              ;create-redlinks-from countries with [code = id2][set color gray]
            set e1  e1 * (1 - (i1 * a5 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a5) * ln(e1 / e2 + 1))
              set poff2 0
            set payoff poff2

            set es  e2
                        ;  print poff2
             set bm1 lput id2 bm1
              set betray-member bm2
          set i-number i-number + 2

          ]

        ]

    ]
;print es
  ]

   set es  e1
   set m  m1
    set pm  pm1
    set ts ts1
    set payoff poff1
        set betray-member bm1
      set coop-member cm1
      ;print es
  ]


  ]


end









to betray

if time > 1
  [

  ask countries ;with [international-effect > n ]
  [
    let ee international-effect
    let e1 es
    let m1 m ;; reputation
    let c1 c ;; connfidence-level
    let cl1 cl ;;culture-type
    let pm1 pm ;;population-mood
    let choose-begray-agent  other countries ;with [international-effect > n]
    let id code
    let neighbor neighbor-list
    let neighbour-list neighbour
    let group-state-betray group-state
    let ts1 ts
    let scl1 second-cl
    let ps political-system
    let sc1 strategy
    let st1 s-type
    let poff1 payoff
    let bm1 betray-member
      let rp1 random-prob
      let cm1 coop-member
      let i1 i
      let gm1 group-member
      let ir1 irrational
  let s1 structure
      let  vp1 virtual-payoff

;;print id
  ask choose-begray-agent
    [
      if state = "close"
      [
      let id2 code
     ;; print id2
      let ee2 international-effect
      let e2 es
      let m2 m
      let c2 c
      let cl2 cl ;;culture-type
        let pm2 pm
        let ts2 ts
        let ps2 political-system
        let group-state-be-betray group-state
        let scl2 second-cl
        let bm2 betray-member
         let sc2 strategy
        let st2 s-type
        let poff2 payoff
          let rp2 random-prob
          let cm2 coop-member
          let gm2 group-member
          let i2 i
          let s2 structure
           let ir2 irrational
          let  vp2 virtual-payoff
      set culture-prob cl1 + cl2

         set s-prob (1 - abs (s1 - s2))

;;print culture-prob
      culture-probability
;;print ln(e1 / e2 )

      ifelse ps != ps2
        [
        set diff-ps-prob 1.3
        ]
          [
           set diff-ps-prob 1
          ]


        if cl1 = cl2 = 7
        [
          set same-cl-prob 0
        ]
   if cl1 = cl2 = 6 ;;穆斯林国家互相合作的概率会低很多 Islamic culture
      [
       set same-cl-prob 1.5
      ]
      if cl1 = cl2 = 5 ;;european countries合作概率会比一般的要高
      [
       set same-cl-prob 0.7
      ]
        if group-state-be-betray = "grouped"
        [
        ;;  set  group-state-influence
        ]
        if  member? id neighbor
        [
          set neighbor-prob 0.8
        ]
        if member? id neighbour-list
        [
          set neighbour-prob 1.5
        ]

          ifelse (member? id gm2) or (member? id2 gm1)
          [

           set group-prob 0.7

          ]
          [
            set group-prob 1
          ]
        ;;print id2
        let betray-probability (a1 * (ee - ee2) + abs a2 * (m1 - m2) + abs a3 * (c1 - c2) ) * cl-betray-prob * same-cl-prob * neighbor-prob * neighbour-prob * diff-ps-prob * group-prob * s-prob


      ;print betray-probability
        ifelse  betray-probability >=  coop-rate

          [
if st1  = "be"


          [
               ;print id
          set sc1 "be"

;print id2
                if st2 = "coop"
                [
                  set sc2 "coop"

                 ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 * (i2 * (- a6) * ln(e1 / e2 + 1))
                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set m2 m2 - a6 * ln ((e1 / e2) + 1)
          set es  e2
            set payoff poff2
                set virtual-payoff vp2
  set bm2 lput id bm2
                set m m2
                set i-number i-number + 2
                set coop-number coop-number + 1
                  ]

                  if st2 = "be"
                  [
            set sc2 "betray"
               ;   create-redlinks-from countries with [code = id][set color red]
                ;  create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * (i1 *  (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2  poff2 + e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                set m1 m1 - a7 * (ln e1 / e2)
                if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
                set m2 m2 - a7 * (ln e1 / e2 + 1)
          set es  e2
                set m m2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                set i-number i-number + 2

                  ]

                  if st2 = "hold"
                  [
            set sc2 "hold"
                    ;create-redlinks-from countries with [code = id][set color gray]
            set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
            set poff2 poff2 + e2 * ((- i2) * a4 * ln(e1 / e2 + 1))
                set e1 e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
                set poff1 poff1 + e1 * ((- i1) * a4 * ln(e1 / e2 + 1))
                 if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
            set payoff poff2
               set es  e2
                set m2 m2 - a4 * ln ((e1 / e2) + 1)

                set m m2
             set bm2 lput id bm2
       set poff1 0
                set i-number i-number + 2
                set coop-number coop-number + 1
                  ]

          if st2 = "tit"
          [

                ifelse  member? id bm2
                [

             set sc2 "be"
               ;   create-redlinks-from countries with [code = id][set color red]
                ;  create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2  poff2 + e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                   if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
                   set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2

            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1

set i-number i-number + 2





                ]
             [
             set sc2 "coop"
                 ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
             set m2 m2 - a6 * ln ((e1 / e2) + 1)
                  if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                   if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
             set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                  set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]





          if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
             set sc2 "be"
                 ; create-redlinks-from countries with [code = id][set color red]
                ; create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2  poff2 + e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                      if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
                      set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                    set i-number i-number + 2


                  ]
                [

                   set sc2 "coop"
                 ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))

                   if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                    if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
                     set m2 m2 - a9 * ln ((e1 / e2) + 1)

             set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                    set i-number i-number + 2
                set coop-number coop-number + 1



                  ]




                ]
             [
             set sc2 "coop"
                 ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln((e1 / e2 + 1))))
            set poff1 poff1 + e1 * (i1 * a9 * ln((e1 / e2 + 1)))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2 poff2 +  e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
                  if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
                   set m2 m2 - a9 * ln ((e1 / e2) + 1)
             set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                  set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]

;print e1
              ;print e2

          ];;if betray-p > coop-rate
  ;; print code
 ;;print betray-probability

          ]



          [

          if (st1 = "coop") or (st1 = "be")

          [
;print id
              ;print id2
            set sc1 "coop"
            if st2  = "coop"
            [
              set sc2 "coop"
              ;create-greenlinks-from countries with [code = id] [set color green]
              ; create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
              set es e2
                set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2 + 1)
                set m m2
              set payoff poff2


                set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2

 ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]









            ]
            if st2 = "hold"
            [
              set sc2 "hold"
              ; create-redlinks-from countries with [code = id][set color gray]

                set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * (- a4) * ln(e1 / e2 + 1))
                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
                set virtual-payoff vp2
             set payoff poff2
                set m2 m2 - a4 * ln (e1 / e2)
                set m m2
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1

            ]

            if st2  = "tit"
            [
                ifelse member? id bm2
                [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
             ;;  create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + i1 * a5 * ln(e1 / e2 + 1))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1) )
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                  if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                  set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
      ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]

                ]
                [
                  set sc2 "be"
              ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                  if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2 poff2 +  e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                    set m2 m2 - a9 * ln ((e1 / e2) + 1)
                  set m m2
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1
                ]

            ]

             if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
             set sc2 "be"
               ;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2  poff2 + e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]
             if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                    set virtual-payoff vp2
                      set m2 m2 - a9 * ln ((e1 / e2) + 1)
                    set m m2
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1

                  ]
                [
 set sc2 "coop"
            ;  create-greenlinks-from countries with [code = id] [set color green]
            ;   create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                    if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                    if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                    set virtual-payoff vp2
                    set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2 + 1)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1
     ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]


                  ]




                ]
             [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
              ; create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                     if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                  set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2 + 1)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
                     ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]

          ]

             ; print poff1
              ;print poff2
          ]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            if st1 = "hold" [
             set sc1 "hold"


                 if st2  = "coop"
            [
              set sc2 "coop"
           ;  create-redlinks-from countries with [code = id][set color gray]
             set e1  e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (( - a4) * ln(e1 / e2 + 1)* i1)
                   if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
              set es e2
              set payoff poff2
 set m1 m1 - a4 * ln (e1 / e2)
                set i-number i-number + 2
                set coop-number coop-number + 1
            ]
            if st2 = "hold"
            [
              set sc2 "hold"
              set e1 e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
              ;  print (i1 * a4 * ln(e1 / e2 + 1)))
              set e2 e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
                   if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]
                if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
               ; print (i2 * a4 * ln(e1 / e2 + 1))
              ; create-redlinks-from countries with [code = id][set color gray]
               ; create-redlinks-to countries with [code = id][set color gray]
              set poff1 poff1 + e1 * (( - a4) * ln(e1 / e2 + 1) * i1)
              set payoff payoff + e2 * (( - a4) * ln(e1 / e2 + 1) * i2)
set i-number i-number + 2



            ]


   if st2  = "tit"
            [
                ifelse member? id bm2
                [
             set sc2 "coop"
           ;  create-redlinks-from countries with [code = id][set color gray]
             set e1  e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * ( - a4 * ln(e1 / e2 + 1) * i1)
                     if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
              set es e2
                   set m1 m1 * (1 - (a4 * ln (e1 / e2 + 1)))
              set payoff poff2
               set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1
                ]
                [
               set  sc2 "be"
            ;  create-redlinks-from countries with [code = id2][set color gray]
            set e1  e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
            set poff1 poff1 - e1 * (i1 *  a4 * ln(e1 / e2 + 1))
   if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
            set payoff poff2
            set es  e2
                  set  m1 m1 * (1 - (a4 * ln (e1 / e2 + 1)))
                  set m m2
                        ;  print poff2
             set bm1 lput id2 bm1
          set i-number i-number + 2
                ]

            ]


            if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
          ;  create-redlinks-from countries with [code = id][set color gray]
            set e1  e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * ((- i1) * a4 * ln(e1 / e2 + 1))
   if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                     set  m1 m1 * (1 - (a4 * ln (e1 / e2 + 1)))
                  set m m2
            set payoff poff2
            set es  e2
                        ;  print poff2
             set bm1 lput id2 bm1
          set i-number i-number + 2

                  ]
                [
  set sc2 "coop"
            ; create-redlinks-from countries with [code = id][set color gray]
             set e1  e1 * (1 - (i1 * a4 * ln(e1 / e2 + 1)))
              set poff1 poff1 - e1 * ( a4 * ln(e1 / e2 + 1) * i1)
   if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                    set m1 m1 * (1 - a4 * ln (e1 / e2 + 1))
              set es e2
              set payoff poff2
set cm1 lput id2 cm1
               set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1

                  ]




                ]
             [
               set sc2 "coop"
             ;create-redlinks-from countries with [code = id][set color gray]
             set e1  e1 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * ( - a4 * ln(e1 / e2 + 1) * i1)
                     if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
              set es e2
              set payoff poff2
                  set m1 m1 * (1 - (a4 * ln (e1 / e2 + 1)))
set cm1 lput id2 cm1
               set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]
            ]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            if st1 = "tit"

           [

              ifelse member? id2 bm1
              [

                set sc1 "be"

                if st2 = "coop"
                [
                  set sc2 "coop"
                   ; create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
                     if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                     if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                     set m2 m2 - a9 * ln ((e1 / e2) + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2

                  set i-number i-number + 2
                set coop-number coop-number + 1
                  ]

                  if st2 = "be"
                  [
            set sc2 "be"
                 ; create-redlinks-from countries with [code = id][set color red]
                 ; create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2 poff2 +  e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                     if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2

                   set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                  set i-number i-number + 2

                  ]

                  if st2 = "hold"
                  [
            set sc2 "hold"
                  ;  create-redlinks-from countries with [code = id][set color gray]
                  set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
            set poff2 poff2 + e2 * ((- i2) * a4 * ln(e1 / e2 + 1))
                     if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                     if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                   set m2 m2 - a4 * ln ((e1 / e2) + 1)
            set m m2
            set payoff poff2
            set es  e2
             set bm2 lput id bm2
       set poff1 0
                  set i-number i-number + 2

                  ]

          if st2 = "tit"
          [

                ifelse  member? id bm2
                [

             set sc2 "be"
                 ; create-redlinks-from countries with [code = id][set color red]
                  ;create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2 poff2 +  e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                      set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                    set i-number i-number + 2



                ]
             [
             set sc2 "coop"
                  ;;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2 poff2 +  e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
                      set m2 m2 - a6 * ln ((e1 / e2) + 1)
                        if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                    set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]





          if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
             set sc2 "be"
                 ; create-redlinks-from countries with [code = id][set color red]
                 ; create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2  poff2  + e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                       set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                      set i-number i-number + 2


                  ]
                [

                   set sc2 "coop"
                   ; create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2 poff2 +  e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))

                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                       set m2 m2 - a6 * ln ((e1 / e2) + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2

set i-number i-number + 2
                set coop-number coop-number + 1

                  ]




                ]


             [
             set sc2 "coop"
                  ;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 +  e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
               if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                     set m2 m2 - a6 * ln ((e1 / e2) + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                    set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]

              ]



              [;ifelse
             set sc1 "coop"



                 if st2  = "coop"
            [
              set sc2 "coop"
           ;  create-redlinks-from countries with [code = id2][set color gray]
             set e1 e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
                  set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * ( a5 * ln(e1 / e2 + 1))* i2
                     if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                   set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set poff1 poff1 + e1 * ( a5 * ln(e1 / e2 + 1)) * i1
              set es e2
 set cm1 lput id2 cm1
              set cm2 lput id cm2
               set coop-member cm2
              set payoff poff2
                  set i-number i-number + 2
                set coop-number coop-number + 2
         ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
            ]
            if st2 = "hold"
            [
              set sc2 "hold"

                  set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
                  set poff2 poff2 + e2 * ((- i2) * a4 * ln(e1 / e2 + 1))

                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
              ; create-redlinks-from countries with [code = id][set color gray]
              ;  create-redlinks-to countries with [code = id][set color gray]


 set m2 m2 - a5 * ln (e1 / e2)
                set m m2
set i-number i-number + 2
                set coop-number coop-number + 1

            ]


  if st2  = "tit"
            [
                ifelse member? id bm2
                [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
             ;;  create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 +  e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                    set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
              set cm2 lput id cm2
               set coop-member cm2

                set i-number i-number + 2
                set coop-number coop-number + 2
                  ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]
                [
                  set sc2 "be"
              ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2  poff2 + e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                     set m2 m2 - a9 * ln ((e1 / e2) + 1)
                    set m m2
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1
                ]

            ]

             if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
             set sc2 "be"
               ;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2  poff2 +  e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2

                       set m2 m2 - a9 * ln ((e1 / e2) + 1)
                    set m m2
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1

                  ]
                [
 set sc2 "coop"
            ;  create-greenlinks-from countries with [code = id] [set color green]
            ;   create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                        set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1

      ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                  ]




                ]

             [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
              ; create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                      set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
           ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]

          ]


            ]

            ]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
            if st1 = "gtit" [
                ifelse member? id2 bm1
                [
                  ifelse rp1 >= g-number
                  [
                    set sc1 "be"
                     if st2 = "coop"
                [
                  set sc2 "coop"
                   ; create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2 poff2 +  e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
                 if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                      set m1 m1 - a6 * ln ((e1 / e2) + 1)
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                      set i-number i-number + 2
                set coop-number coop-number + 1
                  ]

                  if st2 = "be"
                  [
            set sc2 "be"
                ;  create-redlinks-from countries with [code = id][set color red]
                ;  create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2 poff2 +  e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                     set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                        set i-number i-number + 2
                  ]

                  if st2 = "hold"
                  [
            set sc2 "hold"
                  ;  create-redlinks-from countries with [code = id][set color gray]

            set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
            set poff2 poff2 + e2 * ((- i2) * a4 * ln(e1 / e2 + 1))
                    if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                    set m1 m1 - a4 * ln(e1 / e2 + 1)
            set payoff poff2
            set es  e2
             set bm2 lput id bm2

                        set i-number i-number + 2
                set coop-number coop-number + 0
                  ]

          if st2 = "tit"
          [

                ifelse  member? id bm2
                [

             set sc2 "be"
                ;  create-redlinks-from countries with [code = id][set color red]
                ;  create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 +  e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2  poff2 + e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                      set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
  set i-number i-number + 2

                ]
             [
             set sc2 "coop"
                  ;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 +  e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2 poff2 +  e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))

                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                      set m1 m1  - a9 * ln (e1 / e2)
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                          set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]





          if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 >= g-number
                  [
             set sc2 "be"
                ;  create-redlinks-from countries with [code = id][set color red]
               ;   create-redlinks-to countries with [code = id][set color red]
           set e1  e1 * (1 - (i1 * a7 * ln(e1 / e2 + 1)))
             set poff1 poff1 + e1 * ( i1 * (- a7) * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a7 * ln(e1 / e2 + 1)))
            set poff2 poff2 +  e2 *  (i2 * (- a7) * ln(e1 / e2 + 1))
                           if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                 set m1 m1 - a7 * (ln e1 / e2)

                set m2 m2 - a7 * (ln e1 / e2 + 1)
                  set m m2
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                set bm1 lput id2 bm1
                            set i-number i-number + 2

                  ]
                [

                   set sc2 "coop"
                   ; create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - i2 * (a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))

                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                        set m1 m1 - a9 * ln (e1 / e2)
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
set cm1 lput id2 cm1
                         set betray-member bm2
  set i-number i-number + 2
                set coop-number coop-number + 1

                  ]
                ]
             [
             set sc2 "coop"
                 ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 + (i1 * a9 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * a9 * ln(e1 / e2 + 1))
          set e2  e2 *  (1 - (i2 * a6 * ln(e1 / e2 + 1)))
          set poff2  poff2 + e2 *  (i2 * (- a6) * ln(e1 / e2 + 1))
                   if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                       set m1 m1 - a9 * ln (e1 / e2)
          set es  e2
            set payoff poff2
  set bm2 lput id bm2
                          set i-number i-number + 2
                set coop-number coop-number + 1
                ]

          ]

                  ]





                  [

                   set sc1 "coop"


                 if st2  = "coop"
            [
              set sc2 "coop"
            ; create-redlinks-from countries with [code = id][set color gray]
                     set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
             set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * ( a5 * ln(e1 / e2 + 1)) * i2

                     set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set poff1 poff1 + e1 * i1 * a5 * ln(e1 / e2 + 1)
                       if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
              set es e2
              set payoff poff2
                     set cm1 lput id2 cm1
              set cm2 lput id cm2
               set coop-member cm2
                        set i-number i-number + 2
                set coop-number coop-number + 2
                        ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
            ]
            if st2 = "hold"
            [
              set sc2 "hold"

                     set e2  e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
                  if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
             ;  create-redlinks-from countries with [code = id][set color gray]
              ;  create-redlinks-to countries with [code = id][set color gray]

              set payoff payoff +  e2 * ((- a4) * ln(e1 / e2 + 1) * i2)
 set m2 m2 - a4 * ln(e1 / e2 + 1)
                    set m m2
  set i-number i-number + 2
                set coop-number coop-number + 1

            ]


 if st2  = "tit"
            [
                ifelse member? id bm2
                [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
             ;;  create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 +  e2 * (i2 * a5 * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2

                  set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
              ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]
                [
                  set sc2 "be"
              ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2  poff2 + e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                      set m2 m2 - a9 * ln (e1 / e2 + 1)
                      set m m2
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1
                ]

            ]

             if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
             set sc2 "be"
               ;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2 poff2 +  e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                           if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                        set m1  m1   - a9 * ln (e1 / e2 )
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1

                  ]
                [
 set sc2 "coop"
            ;  create-greenlinks-from countries with [code = id] [set color green]
            ;   create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                           if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 1
       ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]


                  ]




                ]

             [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
              ; create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
              set es e2
                       set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
                         ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]

          ]
                  ]
                ]
                [
             set sc1 "coop"


                 if st2  = "coop"
            [
              set sc2 "coop"
            ; create-redlinks-from countries with [code = id][set color gray]
              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
   if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2

                   set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
                   set cm1 lput id2 cm1
              set cm2 lput id cm2
               set coop-member cm2
                      set i-number i-number + 2
                set coop-number coop-number + 2
                      ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
            ]
            if st2 = "hold"
            [
              set sc2 "hold"
              ; create-redlinks-from countries with [code = id][set color gray]
              ;  create-redlinks-to countries with [code = id][set color gray]

              set e2 e2 * (1 - (i2 * a4 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (( - a4) * ln(e1 / e2 + 1)* i2)

                if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]

                       if ir2 = "loss-aversion"
                [

                 set vp2 la * poff2
                ]
             set virtual-payoff vp2
                  set m2   m2 - a5 * ln (e1 / e2)
  set i-number i-number + 2
                set coop-number coop-number + 1
            ]


  if st2  = "tit"
            [
                ifelse member? id bm2
                [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
             ;;  create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                     set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
       ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]
                [
                  set sc2 "be"
              ;   create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
          set poff2 poff2 +  e2 *  (i2 * a9 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2

                    set m2 m2 - a9 * ln (e1 / e2  + 1)
                    set m m2
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1
                ]

            ]

             if st2 = "gtit"
          [
                ifelse  member? id bm2
                [
                  ifelse rp2 > g-number
                  [
             set sc2 "be"
               ;  create-redlinks-from countries with [code = id][set color red]
          set e1  e1 * (1 - (i1 * a6 * ln(e1 / e2 + 1)))
            set poff1 poff1 + e1 * (i1 * (- a6) * ln(e1 / e2 + 1))
         set e2  e2 *  (1 + (i2 * a9 * ln(e1 / e2 + 1)))
                          ;; set e2  e2 *  (1 - (a6 * ln(e2 / e1)))
                      set m2 m2 - a9 * ln (e1 / e2  + 1)
                         if ir1 = "loss-aversion"
                [

                 set vp1 la * poff1
                ]

                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2

                    set m m2
          set poff2  poff2 + e2 *  (i2 * a9 * ln(e1 / e2 + 1))
          set es  e2
            set payoff poff2
                         ;; print poff1
                          ;;print poff2

            set bm1 lput id2 bm1
            set i-number i-number + 2
            set coop-number coop-number + 1

                  ]
                [
 set sc2 "coop"
            ;  create-greenlinks-from countries with [code = id] [set color green]
            ;   create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                         if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                       set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2

        ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]

                  ]




                ]
             [
              set sc2 "coop"
             ; create-greenlinks-from countries with [code = id] [set color green]
              ; create-greenlinks-to countries with [code = id] [set color green]

              set e1  e1 * (1 + (i1 * a5 * ln(e1 / e2 + 1)))
              set poff1 poff1 + e1 * (i1 * a5 * ln(e1 / e2 + 1))
               set e2  e2 * (1 + (i2 * a5 * ln(e1 / e2 + 1)))
              set poff2 poff2 + e2 * (i2 * a5 * ln(e1 / e2 + 1))
                       if ir1 = "loss-aversion"
                [

                 set vp1 poff1
                ]
                  if ir2 = "loss-aversion"
                [

                 set vp2 poff2
                ]
                  set virtual-payoff vp2
                     set m1 m1 + a5 * ln(e1 / e2 + 1)
                set m2 m2 + a5 * ln (e1 / e2)
                set m m2
              set es e2
              set payoff poff2
      set cm1 lput id2 cm1
                set cm2 lput id cm2
                set coop-member cm2
                set i-number i-number + 2
                set coop-number coop-number + 2
             ifelse e1 > e2
                [
                 ifelse cl1 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl1 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                      [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]

                ]
                [
                  ifelse cl2 = 7
                 [
                   ifelse id != "GBR"
                        [
                          ifelse id != "AUS"
                            [
                              ifelse id != "CAN"


                        [
                   set USD USD + 1
                    set currency currency + 1
                              ]
                              [
                               set CAN CAN + 1
                               set currency currency + 1
                              ]
                            ]
                            [
                             set AUS AUS + 1
                             set currency currency + 1
                            ]
                        ]
                        [
                         set GBP GBP + 1
                         set currency currency + 1
                        ]
                   ]
                  [
                   ifelse cl2 = 5
                   [
                     set EUR EUR + 1
                     set currency currency + 1

                    ]
                    [
                      ifelse id2 = "CHN"
                      [

                     set CNY CNY + 1
                      set currency currency + 1
                      ]
                     [
                        ifelse id = "JPN"
                        [

                         set JPY JPY + 1
                          set currency currency + 1
                        ]
                      [
                       set USD USD + 1
                        set currency currency + 1
                      ]
                      ]
                    ]


                  ]


                ]
                ]

          ]
            ]
              ]


              ]



 set betray-member bm2
          ]





    ]
   ;; print betray-memory
        set es  e1
      set virtual-payoff vp1
   set m  m1
    set pm  pm1
    set ts ts1
    set payoff poff1
      set betray-member bm1
      set coop-member cm1

    ]

  ]



end


to union-countries

 ask countries
 [











  ]










end

to score-pool

  ask countries with [irrational != "loss-aversion"]
[


    let tpb type-pool-be
 let tpc type-pool-coop
  let tph type-pool-hold
    let tpt type-pool-tit
    let tpg type-pool-gtit

    let tbc tb-counter
  let tcc tc-counter
 let thc th-counter
    let tht tt-counter
    let thg tg-counter

  if s-type = "be"
    [
     set tbc tbc + 1


    set tpb (tpb + payoff) / (tbc + 0.99)

    ]


      if s-type = "coop"
    [
     set tcc tcc + 1


    set tpc (tpc + payoff) / (tcc + 0.99)

    ]


      if s-type = "hold"
    [
     set thc thc + 1


    set tph (tph + payoff) / (thc + 0.99)

    ]

       if s-type = "tit"
    [
     set tht tht + 1


    set tpt (tpt + payoff) / (tht + 0.99)

    ]

       if s-type = "gtit"
    [
     set thg thg + 1


    set tpg (tpg + payoff) / (thg + 0.99)

    ]

 set type-pool-be tpb
 set  type-pool-coop tpc
  set type-pool-hold tph
    set type-pool-tit tpt
    set type-pool-gtit tpg

    set tb-counter tbc
  set tc-counter tcc
 set  th-counter thc
    set tt-counter tht
    set tg-counter thg
  ]

   ask countries with [irrational = "loss-aversion"]
  [


    let tpb type-pool-be
 let tpc type-pool-coop
  let tph type-pool-hold
    let tpt type-pool-tit
    let tpg type-pool-gtit

    let tbc tb-counter
  let tcc tc-counter
 let thc th-counter
    let tht tt-counter
    let thg tg-counter

  if s-type = "be"
    [
     set tbc tbc + 1


    set tpb (tpb + virtual-payoff) / (tbc + 0.99)

    ]


      if s-type = "coop"
    [
     set tcc tcc + 1


    set tpc (tpc + virtual-payoff) / (tcc + 0.99)

    ]


      if s-type = "hold"
    [
     set thc thc + 1


    set tph (tph + virtual-payoff) / (thc + 0.99)

    ]

       if s-type = "tit"
    [
     set tht tht + 1


    set tpt (tpt + virtual-payoff) / (tht + 0.99)

    ]

       if s-type = "gtit"
    [
     set thg thg + 1


    set tpg (tpg + virtual-payoff) / (thg + 0.99)

    ]

 set type-pool-be tpb
 set  type-pool-coop tpc
  set type-pool-hold tph
    set type-pool-tit tpt
    set type-pool-gtit tpg

    set tb-counter tbc
  set tc-counter tcc
 set  th-counter thc
    set tt-counter tht
    set tg-counter thg
  ]

end


to caculate

  set type-coop sum [payoff] of countries with [s-type = "coop"]

   set type-be sum [payoff] of countries with [s-type = "be"]
   set type-hold sum [payoff] of countries with [s-type = "hold"]

    set type-tit sum [payoff] of countries with [s-type = "tit"]
    set type-gtit sum [payoff] of countries with [s-type = "gtit"]

 set max-type item 0  sort-by > (list (type-coop) (type-be) (type-hold) (type-tit)(type-gtit))

  if max-type = type-coop
 [

     set max-item "coop"
  ]

   if max-type = type-be
 [
    set max-item "be"

  ]

   if max-type = type-hold
 [

    set max-item "hold"
  ]
    if max-type = type-tit
 [

    set max-item "tit"
  ]

    if max-type = type-gtit
 [

    set max-item "gtit"
  ]


ask countries
  [
   if s-type = "coop"
   [
     set type-pool-current type-pool-coop
    ]
     if s-type = "be"
   [
     set type-pool-current type-pool-be
    ]
     if s-type = "tit"
   [
     set type-pool-current type-pool-tit
    ]
     if s-type = "hold"
   [
     set type-pool-current type-pool-hold
    ]
     if s-type = "gtit"
   [
     set type-pool-current type-pool-gtit
    ]


  ]

end


to s-steps
  ask countries with [ irrational = "over-confidence"]
  [

  if (s-type-last-1 = s-type) and (s-type-last-2 = s-type-last-1)
    [
     ifelse (s-type-payoff-1 +  s-type-payoff-2 + payoff) > 0

     [
        set s-type s-type
      ]
      [
       ifelse o > random-exponential 0.5
        [
          set  s-type s-type
        ]
        [

     learn-v4
        ]
      ]

  ]




  ]





end



to learn-all




ifelse lockshocked? = "no"

  [
    ifelse shocked? = "no"
    [
  if max-item  = "coop"
  [
let mutate  countries  with [s-type != "coop"]

   ask mutate

    [


      if type-pool-coop >= 0
      [
       set s-type "coop"
      ]
    ]
    ]







  if max-item  = "be"
  [
let mutate  countries  with [s-type != "be"]

    ask mutate
    [
      if type-pool-be >= 0
      [
       set s-type "be"
      ]
    ]
    ]

   if max-item  = "hold"
  [
let mutate  countries  with [s-type != "hold"]

   ask mutate
    [
      if type-pool-hold >= 0
      [
       set s-type "hold"
      ]
    ]
    ]



    if max-item  = "tit"
  [

let mutate  countries  with [s-type != "tit"]

   ask mutate
    [


      if type-pool-tit >= 0
      [
       set s-type "tit"
      ]
    ]

  ]


    if max-item  = "gtit"
  [
let mutate countries  with [s-type != "gtit"]

   ask mutate
    [


      if type-pool-gtit >= 0
      [
       set s-type "gtit"
      ]
    ]

  ]
    ]
    [
      ask  countries with [i <= 0.30]
     [
      set s-type own-max-item

      ]
      ask countries with [i > 0.30]
    [

       set s-type "coop"

      ]
    ]
  ]
  [

   ask countries
   [
     set s-type   "hold"

    ]

  ]

ask n-of 5 countries
  [
    set s-type one-of ["be" "coop" "tit" "gtit" "hold" ]

  ]



end


to learn-v3

  ask countries
  [

   set s-type own-max-item
  ]


    ask n-of 10 countries
  [
  set s-type one-of ["coop" "be" "hold" "tit" "gtit"]

  ]


end

to learn-v4
   if max-item  = "coop"
  [
    let mutate  countries with [s-type != "coop"]
   ask mutate
    [


      ifelse type-pool-coop >= type-pool-current
      [
       set s-type "coop"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]

  if max-item  = "be"
  [
let mutate  countries   with [s-type != "be"]
   ask mutate
    [
      ifelse type-pool-be >= type-pool-current
      [
       set s-type "be"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]
   if max-item  = "hold"
  [
let mutate  countries   with [s-type != "hold"]
   ask mutate
    [
      ifelse type-pool-hold >= type-pool-current
      [
       set s-type "hold"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    if max-item  = "tit"
  [
    let mutate  countries with [s-type != "tit"]
   ask mutate
    [


      ifelse type-pool-tit >= type-pool-current
      [
       set s-type "tit"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    if max-item  = "gtit"
  [
let mutate  countries with [s-type != "gtit"]
   ask mutate
    [


      ifelse type-pool-gtit >= type-pool-current
      [
       set s-type "gtit"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    ask n-of 10 countries with [irrational != "over-confidence"]
  [
  set s-type one-of ["coop" "be" "hold" "tit" "gtit"]

  ]
end

to learn-v2

  if max-item  = "coop"
  [
let mutate  countries  with [s-type != "coop"]
   ask mutate
    [


      ifelse type-pool-coop >= 0
      [
       set s-type "coop"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]

  if max-item  = "be"
  [
let mutate  countries  with [s-type != "be"]
   ask mutate
    [
      ifelse type-pool-be >= 0
      [
       set s-type "be"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]
   if max-item  = "hold"
  [
let mutate  countries  with [s-type != "hold"]
   ask mutate
    [
      ifelse type-pool-hold >= 0
      [
       set s-type "hold"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    if max-item  = "tit"
  [
let mutate  countries  with [s-type != "tit"]
   ask mutate
    [


      ifelse type-pool-tit >= 0
      [
       set s-type "tit"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    if max-item  = "gtit"
  [
let mutate  countries  with [s-type != "gtit"]
   ask mutate
    [


      ifelse type-pool-gtit >= 0
      [
       set s-type "gtit"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    ask n-of 10 countries
  [
  set s-type one-of ["coop" "be" "hold" "tit" "gtit"]

  ]

end






to learn
  if max-item  = "coop"
  [
let mutate one-of countries  with [s-type != "coop"]
   ask mutate
    [


      ifelse type-pool-coop >= 0
      [
       set s-type "coop"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]

  if max-item  = "be"
  [
let mutate one-of countries  with [s-type != "be"]
   ask mutate
    [
      ifelse type-pool-be >= 0
      [
       set s-type "be"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]
   if max-item  = "hold"
  [
let mutate one-of countries  with [s-type != "hold"]
   ask mutate
    [
      ifelse type-pool-hold >= 0
      [
       set s-type "hold"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    if max-item  = "tit"
  [
let mutate one-of countries  with [s-type != "tit"]
   ask mutate
    [


      ifelse type-pool-tit >= 0
      [
       set s-type "tit"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    if max-item  = "gtit"
  [
let mutate one-of countries  with [s-type != "gtit"]
   ask mutate
    [


      ifelse type-pool-gtit >= 0
      [
       set s-type "gtit"
      ]
      [
       set s-type own-max-item
      ]
    ]
  ]


    ask n-of 10 countries
  [
  set s-type one-of ["coop" "be" "hold" "tit" "gtit"]

  ]
end



to 	cooperate



    set last-sum-es sum [international-effect] of countries



    ask countries with [international-effect < n]
  [
    let id code
      let ee-low international-effect
      let  es1 es
      let m-low m
      let c-low c
    let cl1 cl
let pm-low pm
    let ps1 political-system
    let neighbour1  neighbour
      let neighbor neighbor-list

    ;;print code
   ;; print neighbor
      let new-union-agent  other countries with [international-effect > n]

      ask new-union-agent
    [
      let id2 code

        let ee-high international-effect
        let es2 es
        let m-high m
        let c-high c
        let pm-high pm
         let cl2 cl
      let ps2 political-system
      let cm coop-member
     ;; print es1 / es2
if ps1 = "so"
      [
        if ps2 = "cp"
        [
          set diff-ps-prob 0
        ]
      ]
    if cl1 = cl2 = 6
      [
       set same-cl-prob 0.6
      ]

    if cl1 = cl2 = 5
      [
       set same-cl-prob 1.5
      ]
if ( cl1 = 1 ) and  (cl2 = 7)
      [
       set same-cl-prob 0.7
      ]
      if member? id2 neighbor
      [
        if member? id2 neighbour
        [
          set neighbor-prob 1.1
        ]

          set neighbor-prob 1.3

      ]
      let cooperation-p ((( ee-high - ee-low) * hl1 + abs (m-high + m-low) * hl2  + abs (pm-high + pm-low) * hl3))  * same-cl-prob * neighbor-prob * diff-ps-prob

     ;; print link-neighbors
;;print cooperation-p
        if cooperation-p < p-coo
      [

       create-greenlinks-from countries with [code = id] [set color green]
     ;;  print code
      ;;  print cooperation-p
        set pm-low pm-low + 1 * ( a5 * (1 / ln (es1 / es2 + 2)))
        set pm-high pm-high + 1 * (a5 * ln (es1 / es2 + 3 ))
        set es2 es2 + es1 * (a5 * (ln (es2 / es1 + 1)) * (ln (m-low + m-high + 2)))
        set es1 es1 * (1 + a5 * ln (es2 / es1 + 1) * (ln (m-low + m-high + 2)))
       set m-low m-low + 1 * ( a5 * (1 / ln (es1 / es2 + 2)))
       set m-high m-high + 1 * (a5 * (ln (es1 / es2) + 2))

        set es es2
        set pm  pm-high
        set m  m-high
        set cm lput id cm
      ]
     set coop-member cm
    ]
    set es  es1
set pm  pm-low
    set m  m-low
 ]

end


to choose-to-coo
  ask countries with [international-effect > n]
  [

    let ies initial-es
    if es <= ies * k2
    [
      set state "open"
      let id code
      let ie-self international-effect
      let ee-self es
      let m-self m
      let c-self c
      let ps1 political-system
      let cl1 cl
      let ts1 ts
      let coop-member1 coop-member
      let pm1 pm
      let neighbor  link-neighbors with [international-effect > n ]
     ask neighbor
      [
let id2 code
        let ie-neighbor international-effect
       ;;print code
       ;; print ie-neighbor
      let ee-neighbor es
      let m-neighbor m
      let c-neighbor c

         let ps2 political-system
        let cl2 cl
        let pm2 pm
        let m2 m
        let ts2 ts
        let coop-member2 coop-member
      let coo-p d1 * abs (ie-neighbor - ie-self) + d2 * abs (m-neighbor - m-self) + d3 * abs (c-neighbor - c-self)
       ;; print coo-p

      if coo-p >= emergency-p
      [
         ;; print code
         ;; print coo-p
          ask links with [color = red][die]
          create-greenlinks-from countries with [code = id ][set color green]


       set ee-self ee-self *  (1 + ln((ee-self / ee-neighbor) + 2 ) * a11)
        set ee-neighbor ee-neighbor *  (1 + ln ((ee-neighbor / ee-self) ^ 2 ) * a7)

   set ts1 ts1  + 1 * (ln(ee-self / ee-neighbor + 1)  * a11 )
           set ts2 ts2  + 1 * (ln(ee-neighbor / ee-self + 1)  * a7 )
          set m-self m-self * (1 - ln( (ee-neighbor / ee-self) + 1 ) * a11)

         set m-neighbor m-neighbor * (1 - ln( ( ee-self / ee-neighbor) + 1 ) * a7)
        set es  ee-neighbor
          set ts ts2
       set coop-member1 lput id2 coop-member1
          set coop-member2 lput id coop-member2
      set coop-member coop-member2
set m m-neighbor
         ;; if state = "close"
        ]
      ]
      set coop-member coop-member1
      set es  ee-self
      set m m-self
      set ts ts1
    ]
    ]

  set total-sum-es sum [international-effect] of countries

end



to state-change

  ask countries with [international-effect > n]
  [
   let es-now es

    if es-now > k3 * initial-es
    [
     set state "close"
    ]


  ]
end






to in-the-union

ask countries
  [
    let es-self es
    let pn-self pn
    let neighbor countries in-radius 3


 ask neighbor
    [




    ]






    ]











end

to evo







end


to update-papr

  let sum-es sum  [es] of countries
  let  sum-pn sum  [pn] of countries
  let sum-int-eff sum [international-effect ] of countries

  ask countries
  [
  let pn-last last-pn
    let pn-present pn
    let ms-now ms
    let ms-last last-ms
    let temp pn-present - pn-last
    if temp >= 0
    [
      set es es * (1 + (temp / pn-present) * (1 / ln(temp + 2) - (6 / 5)))
      ]
    if temp < 0
    [
     set es es * (1 + (temp / pn-present) * (ln(temp + 1)) )

    ]


  ]



   ;; let temp ((pn-present - pn-last) / pn-last)
    ;;print temp
   ;; if abs temp > 1
 ;; [
   ;; set temp 1
   ;; ]
   ;; if temp >= 0
    ;;[
      ;;set es-self es-self * (1 + 1 / ln(temp + 3 ) / 100 )

   ;; ]
   ;; if temp < 0
    ;;[
      ;;set es-self es-self * (1 - ln(temp + 1) / 10)

   ;; ]
   ;; set es es-self
      ;;set ts   (ln ((es  / sum-es ) + 0.5 )) * last-ts * (ln ( (last-pn / sum-pn) + 1) )
  ;; set pn  ln ( 0.99 + (  (es  - last-es) / es ) ) * pn / 10 + last-pn
    ;;print pn
  ;;  set ts ln (0.99 + ((es - last-es / es) / es )) * ts / 10 + last-ts
     ;; set es ln (abs( k1 * ln (1 - es / sum-es + 0.5) * (pn - last-pn ) + (1 - k1) * ln ((1 + es / sum-es) ) * (1 - k1) * (ts - last-ts) + last-es  ) + 0.5)


ask countries
  [
      set international-effect ( b1 * es + b2  * ms + b3 * nr + b4 * ts + b5 * pn)
  ]

    set time time + 1
end

to react-differ


ask countries
[















  ]















end

to sum-up

;  set differ-es (total-sum-es - last-sum-es) / last-sum-es

  set sum-all-es sum [es] of countries


  set sum-all-ts sum [ts] of countries


 set sum-over-confidence sum [es] of countries with [irrational = "over-confidence"]
  set sum-loss-aversion sum [es] of countries with [irrational = "loss-aversion"]
  set sum-rational sum [es] of countries with [irrational-type = "rational"]

  set change-rate ((sum-all-es - sum-es-last) / sum-es-last) * 100

  ;set change-rate-over-confidence ((sum-over-confidence - sum-over-confidence-last) / sum-over-confidence-last) * 100
  set change-rate-loss-aversion ((sum-loss-aversion - sum-loss-aversion-last) / sum-loss-aversion-last) * 100
  set change-rate-rational ((sum-rational - sum-rational-last) / sum-rational-last) * 100
  ;;print change-rate

  set change-rate-ts ((sum-all-ts - sum-ts-last) / sum-ts-last) * 100

if time mod 2 = 0
  [
ask countries
  [

    set betray-member []


  ]

  ]

 set  count-be  count countries with [s-type = "be"] / count countries
  set count-coop  count countries with [s-type = "coop"] / count countries
  set count-hold  count countries with [s-type = "hold"] / count countries
  set count-tit count countries with [s-type = "tit"] / count countries
 set  count-gtit count countries with [s-type = "gtit"] / count countries

end





to record-global-data
  file-open "gdp-loss-high-1.csv"



  file-print csv:to-row (list  time sum [es] of countries  )

file-close

end


to record-global-data-v1
  file-open "type-loss-high-1.csv"



  file-print csv:to-row (list  time count-be count-coop count-hold count-tit  count-gtit   )

file-close

end

to record-global-data-v2
  file-open "change-rate-loss-high-1.csv"



  file-print csv:to-row (list  time change-rate change-rate-over-confidence change-rate-rational change-rate-loss-aversion )

file-close

end

to  reset-turtles-color
  ask countries
  [
    set international-effect  ( ba * es + bb  * ms + bc * nr + bd * ts + be * pn)
   if international-effect  > n
    [
    set color red
    ]
   if international-effect < n
    [
     set color blue
    ]

  ]
   set counter-hies count countries with [international-effect > n]
end



to change-link-color
  ask links with [color = green]
  [
   set green-link-time green-link-time + 1
    if green-link-time > green-link-to-white-time
    [
      set color white

    ]
  ]
   ask links with [color = red]
  [
   set red-link-time red-link-time + 1
    if red-link-time > red-link-break-time
    [
      die

    ]
  ]

end
@#$#@#$#@
GRAPHICS-WINDOW
439
11
1350
503
-1
-1
3.0
1
10
1
1
1
0
0
0
1
-150
150
-80
80
0
0
1
ticks
30.0

BUTTON
22
44
88
77
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
126
43
189
76
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
903
526
1075
559
a1
a1
0
0.5
0.004
0.001
1
NIL
HORIZONTAL

SLIDER
903
558
1075
591
a2
a2
0
1
0.24
0.01
1
NIL
HORIZONTAL

SLIDER
851
887
1023
920
a3
a3
0
1
0.2
0.01
1
NIL
HORIZONTAL

SLIDER
46
556
218
589
a5
a5
0
1
5.0E-6
0.000001
1
NIL
HORIZONTAL

SLIDER
44
661
216
694
a6
a6
0
1
4.0E-6
0.000001
1
NIL
HORIZONTAL

SLIDER
239
245
411
278
p-betray
p-betray
0
1
0.31532338485080225
0.01
1
NIL
HORIZONTAL

SLIDER
239
154
411
187
q
q
0
1
0.56
0.01
1
NIL
HORIZONTAL

SLIDER
13
180
190
213
max-union-numbers
max-union-numbers
0
10
5.0
1
1
NIL
HORIZONTAL

SLIDER
12
210
193
243
min-union-numbers
min-union-numbers
0
max-union-numbers
5.0
1
1
NIL
HORIZONTAL

BUTTON
217
44
295
77
goonce
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
5
242
207
275
green-link-to-white-time
green-link-to-white-time
0
10
1.0
1
1
NIL
HORIZONTAL

SLIDER
4
277
182
310
red-link-break-time
red-link-break-time
0
10
2.0
1
1
NIL
HORIZONTAL

SLIDER
14
149
187
182
stop-ticks
stop-ticks
0
100000
100000.0
1
1
NIL
HORIZONTAL

SLIDER
9
338
181
371
b1
b1
0
1
0.45
0.01
1
NIL
HORIZONTAL

SLIDER
10
372
182
405
b2
b2
0
1
0.35
0.01
1
NIL
HORIZONTAL

SLIDER
10
404
182
437
b3
b3
0
1
0.89
0.01
1
NIL
HORIZONTAL

SLIDER
9
436
181
469
b4
b4
0
1
0.1
0.01
1
NIL
HORIZONTAL

SLIDER
2
118
222
151
choose-countries-total-number
choose-countries-total-number
0
100
100.0
1
1
NIL
HORIZONTAL

SLIDER
8
467
180
500
b5
b5
0
1
0.05
0.01
1
NIL
HORIZONTAL

SLIDER
247
774
419
807
k1
k1
0
1
0.5
0.01
1
NIL
HORIZONTAL

SLIDER
696
854
868
887
d1
d1
0
1
0.006
0.001
1
NIL
HORIZONTAL

SLIDER
696
887
868
920
d2
d2
0
1
0.06
0.01
1
NIL
HORIZONTAL

SLIDER
696
920
868
953
d3
d3
0
1
0.11
0.01
1
NIL
HORIZONTAL

MONITOR
195
476
424
521
 total-sum-es 
total-sum-es
30
1
11

MONITOR
430
631
628
676
                      differ-es                
differ-es
17
1
11

MONITOR
467
508
663
553
                    last-sum-es           
last-sum-es
17
1
11

SLIDER
239
124
411
157
n
n
0
100
11.0
1
1
NIL
HORIZONTAL

TEXTBOX
162
521
312
539
                interact
11
15.0
1

TEXTBOX
72
104
222
122
setup point
11
15.0
1

TEXTBOX
31
319
181
337
international-effect-part
11
15.0
1

TEXTBOX
93
940
243
958
result
11
15.0
1

SLIDER
47
525
219
558
a7
a7
0
1
3.0E-6
0.000001
1
NIL
HORIZONTAL

SLIDER
420
774
592
807
k2
k2
0
1
1.0
0.001
1
NIL
HORIZONTAL

TEXTBOX
323
756
473
774
tec
11
0.0
1

TEXTBOX
431
743
581
771
\nTolerance level\n
11
0.0
1

SLIDER
44
692
216
725
a8
a8
0
1
0.0
0.00001
1
NIL
HORIZONTAL

SLIDER
44
724
216
757
a9
a9
0
1
6.0E-6
0.000001
1
NIL
HORIZONTAL

SLIDER
43
756
215
789
a10
a10
0
1
0.0
0.00001
1
NIL
HORIZONTAL

TEXTBOX
253
547
403
623
a7要大于a9而且也要大于a5\n\n
15
0.0
0

TEXTBOX
99
797
249
867
a6 > a8\n
11
0.0
1

TEXTBOX
443
815
593
843
如果掉到了k2的e就会选择合作
11
0.0
1

TEXTBOX
965
512
1115
530
背叛成功率
11
0.0
1

SLIDER
238
365
410
398
p1
p1
0
1
0.142
0.001
1
NIL
HORIZONTAL

SLIDER
238
397
410
430
p2
p2
0
1
0.067
0.001
1
NIL
HORIZONTAL

SLIDER
237
430
409
463
p3
p3
0
1
0.082
0.001
1
NIL
HORIZONTAL

TEXTBOX
31
508
181
526
b1+b2+b3+b4+b5 = 1\n
11
0.0
1

SLIDER
689
697
861
730
hl1
hl1
0
0.5
0.005
0.001
1
NIL
HORIZONTAL

SLIDER
689
730
861
763
hl2
hl2
0
1
0.35
0.01
1
NIL
HORIZONTAL

SLIDER
690
761
862
794
hl3
hl3
0
1
0.2
0.01
1
NIL
HORIZONTAL

SLIDER
240
214
412
247
p-coo
p-coo
0
1
0.0
0.01
1
NIL
HORIZONTAL

TEXTBOX
292
969
442
987
合作成功率\n
11
0.0
1

TEXTBOX
706
800
856
842
 背叛成功率要比合作成功率要低\n
11
0.0
1

SLIDER
238
276
410
309
emergency-p
emergency-p
0
1
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
423
842
595
875
k3
k3
1
2
1.035
0.001
1
NIL
HORIZONTAL

TEXTBOX
480
892
630
910
膨胀指数
11
0.0
1

SLIDER
236
670
408
703
a11
a11
0
1
9.0E-5
0.00001
1
NIL
HORIZONTAL

TEXTBOX
282
715
432
733
a11要小于a7
11
0.0
1

TEXTBOX
86
622
236
640
a5 > a9 > a10
11
0.0
1

MONITOR
1698
10
1876
55
NIL
sum-all-es
17
1
11

SLIDER
277
878
449
911
ff1
ff1
0
1
1.0E-4
0.00001
1
NIL
HORIZONTAL

SLIDER
279
911
451
944
ff2
ff2
0
1
6.0E-5
0.00001
1
NIL
HORIZONTAL

MONITOR
736
509
825
554
NIL
change-rate
17
1
11

SLIDER
47
839
219
872
a12
a12
0
1
6.0E-5
0.00001
1
NIL
HORIZONTAL

SLIDER
47
870
219
903
a13
a13
0
1
6.0E-5
0.00001
1
NIL
HORIZONTAL

PLOT
1279
513
1888
909
change-rate
time
change rate
0.0
10.0
-1.0
1.0
true
true
"" ""
PENS
"change-rate" 1.0 0 -16777216 true "" "plot change-rate * 100"
"rational" 1.0 0 -2674135 true "" "plot change-rate-rational * 100"
"loss-aversion" 1.0 0 -13345367 true "" "plot change-rate-loss-aversion * 100"

MONITOR
503
931
586
976
count coop
count countries with [international-effect > n] with [s-type = \"coop\"] /  count countries with [international-effect > n]
17
1
11

MONITOR
505
976
572
1021
count be
count countries with [s-type = \"be\"] with [international-effect > n] /  count countries with [international-effect > n]
17
1
11

MONITOR
948
726
1028
771
count hold
count countries  with [s-type = \"hold\"] with [international-effect > n] /  count countries with [international-effect > n]
17
1
11

MONITOR
949
766
1022
811
counnt tit
count countries  with [s-type = \"tit\"] with [international-effect > n] /  count countries with [international-effect > n]
17
1
11

MONITOR
950
811
1023
856
count gtit
count countries  with [s-type = \"gtit\"] with [international-effect > n] /  count countries with [international-effect > n]
17
1
11

MONITOR
1111
195
1186
240
NIL
coop-rate
17
1
11

MONITOR
345
34
411
79
NIL
stt-state
17
1
11

SWITCH
239
603
395
636
stt-state-switch
stt-state-switch
1
1
-1000

MONITOR
1484
12
1541
57
NIL
stt
17
1
11

MONITOR
709
861
787
906
NIL
shocked?
17
1
11

SLIDER
45
590
217
623
a4
a4
0
1
2.0E-6
0.000001
1
NIL
HORIZONTAL

MONITOR
1112
516
1248
561
NIL
lockshocked?
17
1
11

MONITOR
1429
108
1583
153
NIL
USD / (currency + 0.1)
17
1
11

MONITOR
1588
108
1740
153
NIL
EUR / (currency + 0.1)
17
1
11

MONITOR
1132
734
1205
779
NIL
max-item
17
1
11

PLOT
614
538
1231
890
plot 2
time
numbers
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"coop" 1.0 0 -16777216 true "" "plot count countries with [s-type = \"coop\"] / count countries "
"be" 1.0 0 -13840069 true "" "plot count countries with [s-type = \"be\"] / count countries "
"hold" 1.0 0 -2674135 true "" "plot count countries with [s-type = \"hold\"] / count countries "
"tit" 1.0 0 -955883 true "" "plot count countries with [s-type = \"tit\"] / count countries "
"gtit" 1.0 0 -6459832 true "" "plot count countries with [s-type = \"gtit\"] / count countries "

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

curve
1.1
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 1 1.0 0.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
