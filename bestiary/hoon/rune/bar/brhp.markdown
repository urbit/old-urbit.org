---
layout: subpage
category: bar
title: barhep
---

`|-`, `barhep`, `[%brhp p=twig]` is a synthetic hoon that produces
a dry `%gold` trap and kicks it.

###Definition###

    ++  twig  
      $%  [%brhp p=twig]
      ==

###Regular form (tall)###

Kingside:

    |-
    p

Queenside:
    
    |-  p

###Regular form (wide)###

    |-(p)

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brhp *]
      ==

###Notes###

See the bestiary of core patterns in chapter 11.
