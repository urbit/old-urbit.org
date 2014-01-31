---
layout: post
category: doc
title: `:+`, `collus`, `%clls`
---

###Synopsis###

`:+`, `collus`, `[%clls p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%clls p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clls *]
      ==

###Notes###

