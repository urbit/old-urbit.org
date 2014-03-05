---
layout: subpage
category: wut
title: wutbar
---

`?|`, `wutbar`, `[%wtbr p=tusk]` is a synthetic hoon that
computes the "or" of the loobeans in `p`.

###Definition###

    ++  twig  
      $%  [%wtbr p=tusk]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

    ?|  i.p
        i.t.p
        i.t.t.p
    ==

###Regular form (wide)###

    ?|(i.p i.t.p i.t.t.p)

###Irregular form###

    |(i.p i.t.p i.t.t.p)

###Expansion###

    ++  open
      ^-  twig
      ?-    gen
          [%wtbr *]
        |-
        ?~(p.gen [%dtzz %f 1] [%wtcl i.p.gen [%dtzz %f 0] $(p.gen t.p.gen)])
      ==

###Notes###

Short-circuiting and type inference work as expected in `?|`.

