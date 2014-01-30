---
layout: post
category: doc
title: `:%`, `colcen`, `%clcn`
---

###Synopsis###

`:%`, `colcen`, `[%clcn p=tusk]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%clcn p=twig]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clcn *]
      ==

###Notes###

