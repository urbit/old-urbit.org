---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 4
title: buccen
---



`$%`, `buccen`, is a tile hoon that 

###Definition###

    ++  noil
      |=  tol=?
      =<  ;~  pfix  buc
            %-  stew  
            ^.  stet  ^.  limo
            :~
              ['|' (rung bar %reed exqb)]
              ['&' (rung pam %bush exqb)]
              ['?' (rung wut %fern exqc)]
              ['_' (rung cab %weed exqd)]
              ['^' (rung ket %herb exqd)]
              ['=' (rung tis %bark exqe)]
              :-  '+'
                %+  cook
                  |=([a=tile b=tile] [%weed [%brls a [%bccb b]]])
                ;~(pfix lus (toad exqb))
              :-  '%'
                ;~  pfix  cen
                  %+  sear
                    |=  a=(list tile)  ^-  (unit tile)
                    =-  ?~(b ~ ?~(u.b ~ [~ %kelp i.u.b t.u.b]))
                    ^=  b
                    |-  ^-  (unit (list line))
                    ?~  a  [~ ~]
                    =+  c=$(a t.a)
                    ?~  c  ~
                    ?.  ?=([[%leaf *] *] i.a)  ~
                    [~ [p.i.a q.i.a] u.c]
                  (toad exqc)
                ==
            ==
          ==

###Regular form (tall)###


###Regular form (wide)###


###Irregular form###


###Notes###

See the discussion of tiles in chapter 9.
