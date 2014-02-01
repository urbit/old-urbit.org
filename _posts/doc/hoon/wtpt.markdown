---
layout: post
category: doc
title: `?@`, `wutpat`, `%wtpt`
---

###Synopsis###
`?@`, `wutpat`, `[%wtpt p=wing q=twig r=twig]` is a synthetic hoon that
evaluates `q` if `p` is equal to the bunt for its tile, otherwise `r`
is evaluated.

###Definition###

    ++  twig  
      $%  [%wtpt p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtpt *]
      ==

###Notes###

