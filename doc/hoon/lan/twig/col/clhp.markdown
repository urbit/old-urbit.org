---
layout: subpage
category: col
title: colhep
---


`:-`, `colhep`, `[%clhp p=twig q=twig]` is a synthetic hoon that
produces the cell `[p q]`.

###Definition###

    ++  twig  
      $%  [%clhp p=twig q=twig]
      ==

###Regular form (tall)###

    :-  p
    q

###Regular form (wide)###

    :-(p q)

###Irregular form###

    [p q]

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%clhp *]  [p.gen q.gen]
      ==
