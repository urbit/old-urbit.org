---
layout: post
category: doc
title: `:+`, `collus`, `%clls`
---

###Synopsis###

`:+`, `collus`, `[%clls p=twig q=twig r=twig]` is a synthetic hoon that
creates the cell [p q r].

###Definition###

    ++  twig  
      $%  [%clls p=twig q=twig r=twig]
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

