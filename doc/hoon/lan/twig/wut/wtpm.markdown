---
layout: subpage
category: wut
title: wutpam
---

`?&`, `wutpam`, `[%wtpm p=tusk]` is a synthetic hoon that
computes the "and" of the loobeans in `p`.

###Definition###

    ++  twig  
      $%  [%wtpm p=tusk]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

    ?&  i.p
        i.t.p
        i.t.t.p
    ==

###Regular form (wide)###

    ?&(i.p i.t.p i.t.t.p)

###Irregular form###

    &(i.p i.t.p i.t.t.p)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtpm *]
        |-
        ?~(p.gen [%dtzz %f 0] [%wtcl i.p.gen $(p.gen t.p.gen) [%dtzz %f 1]])
      ==

###Notes###

Short-circuiting and type inference work as expected in `?&`.
