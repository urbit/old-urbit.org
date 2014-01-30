---
layout: post
category: doc
title: `|+`, `barlus`, `%brls`
---

###Synopsis###

`|+`, `barlus`, `[%brls p=tile q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%brls p=tile q=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brls *]
        [%ktbr [%brts p.gen q.gen]]
      ==

###Notes###

