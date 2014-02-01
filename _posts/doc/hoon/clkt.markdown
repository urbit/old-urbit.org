---
layout: post
category: doc
title: `:^`, `colket`, `%clkt`
---

###Synopsis###

`:^`, `colket`, `[%clkt p=twig q=twig r=twig s=twig]` is a synthetic hoon that
creates a [p q r s] cell.

###Definition###

    ++  twig  
      $%  [%clkt p=twig q=twig r=twig s=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clkt *]
      ==

###Notes###

