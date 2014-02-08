---
layout: subpage
category: wut
title: wutket
---

`?^`, `wutket`, `[%wtkt p=wing q=twig r=twig]` is a synthetic hoon
that evaluates `r` if `p` is equal to the bunt for its tile, otherwise
`q` is evaluated.
###Definition###

    ++  twig  
      $%  [%wtkt p=wing q=twig r=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtkt *]
      ==

###Notes###

