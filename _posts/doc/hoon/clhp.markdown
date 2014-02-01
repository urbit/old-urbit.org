---
layout: post
category: doc
title: `:-`, `colhep`, `%clhp`
---

###Synopsis###

`:-`, `colhep`, `[%clhp p=twig q=twig]` is a synthetic hoon that
creates the cell [p q].
###Definition###

    ++  twig  
      $%  [%clhp p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clhp *]
      ==

###Notes###

