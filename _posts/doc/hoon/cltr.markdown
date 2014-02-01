---
layout: post
category: doc
title: `:*`, `coltar`, `%cltr`
---

###Synopsis###

`:*`, `coltar`, `[%cltr p=tusk]` is a synthetic hoon that takes a
sequence of twigs and produces a cell containing them in order.

###Definition###

    ++  twig  
      $%  [%cltr p=tusk]
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

