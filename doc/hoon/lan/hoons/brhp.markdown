---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 17
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

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brhp *]
      ==

###Notes###

See the bestiary of core patterns in chapter 11.
