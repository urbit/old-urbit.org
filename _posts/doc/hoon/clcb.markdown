---
layout: post
category: doc
title: `:_`, `colcab`, `%clcb`
---

###Synopsis###

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
