---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 23
title: colcab
---



`:_`, `colcab`, `[%clcb p=twig q=twig]` is a synthetic hoon that
produces the cell `[q p]`.

###Definition###

    ++  twig  
      $%  [%clcb p=twig q=twig]
      ==

###Regular form (tall)###

    :_  p
    q

###Regular form (wide)###

    :_(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%clcb *]  [q.gen p.gen]
      ==

###Notes###

See also `%clhp`.
