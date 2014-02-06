---
layout: post
category: doc
title: `?+`, `wutlus`, `%wtls`
---

###Synopsis###

`?+`, `wutlus`, `[%wtls p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%wtls p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtls *]
      ==

###Notes###

