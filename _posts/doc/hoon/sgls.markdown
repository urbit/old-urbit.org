---
layout: post
category: doc
title: `~+`, `siglus`, `%sgls`
---

###Synopsis###

`~+`, `siglus`, `[%sgls p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%sgls p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%sgls *]
      ==

###Notes###

