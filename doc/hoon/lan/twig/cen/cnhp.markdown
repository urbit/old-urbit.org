---
layout: subpage
category: cen
title: cenhep
---

`%-`, `cenhep`, `[%cnhp p=twig q=tusk]` is a synthetic hoon that
slams the gate `p` with `[%cltr q]`

###Definition###

    ++  twig  
      $%  [%cnhp p=twig q=tusk]
      ==

###Regular form (tall)###
  
    %-  p
    [i.q i.t.q]

###Regular form (wide)###

    %-(p i.q i.t.q)

###Irregular form###

    (p i.q i.t.q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnhp *]
        ?~(q.gen [%tsgr p.gen [%cnzy %$]] [%cncl p.gen [%cltr q.gen]])
      ==
