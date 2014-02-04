---
layout: post
category: doc
title: `:~`, `colsig`, `%clsg`
---

###Synopsis###

`:~`, `colsig`, `[%clsg p=tusk]` is a synthetic hoon that takes a
sequence of twigs and creates a null-terminated cell, geometrically
compatible with a list.

###Definition###

    ++  twig  
      $%  [%clsg p=tusk]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clsg *]
      ==

###Notes###

