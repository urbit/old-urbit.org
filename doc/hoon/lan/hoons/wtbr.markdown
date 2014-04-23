---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 86
title: wutbar
---

#[wutbar, `?|`, %wtbr](#wtbr)

##Syntax

`?|`, `wutbar`, `[%wtbr p=tusk]` is a synthetic hoon that
computes the "or" of the loobeans in `p`.

###Definition

    ++  twig  
      $%  [%wtbr p=tusk]
      ==
    ++  tusk  (list twig)

###Form

####Tall

    ?|  i.p
        i.t.p
        i.t.t.p
    ==

####Wide

    ?|(i.p i.t.p i.t.t.p)

####Irregular

    |(i.p i.t.p i.t.t.p)

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%wtbr *]
        |-
        ?~(p.gen [%dtzz %f 1] [%wtcl i.p.gen [%dtzz %f 0] $(p.gen t.p.gen)])
      ==

###Notes

Short-circuiting and type inference work as expected in `?|`.
