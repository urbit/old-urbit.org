---
layout: post
category: doc
title: `|-`, `barhep`, `%brhp`
---

###Synopsis###

`|-`, `barhep`, `[%brhp p=twig]` is a synthetic hoon that creates a
core with a single dry arm (like `|.`, `bardot`) and immediately
activates it.

###Definition###

    ++  twig  
      $%  [%brhp p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brhp *]
      ==

###Notes###

