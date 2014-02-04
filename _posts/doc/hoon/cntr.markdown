---
layout: post
category: doc
title: `%*`, `centar`, `%cntr`
---

###Synopsis###

`%*`, `centar`, `[%cntr p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%cntr p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cntr *]
      ==

###Notes###

