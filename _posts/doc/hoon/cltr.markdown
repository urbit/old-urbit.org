---
layout: post
category: doc
title: `:*`, `coltar`, `%cltr`
---

###Synopsis###

`:*`, `coltar`, `[%cltr p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%cltr p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cltr *]
      ==

###Notes###

