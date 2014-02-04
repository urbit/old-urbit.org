---
layout: post
category: doc
title: `%+`, `cenlus`, `%cnls`
---

###Synopsis###

`%+`, `cenlus`, `[%cnls p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%cnls p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnls *]
      ==

###Notes###

