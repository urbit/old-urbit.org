---
layout: post
category: doc
title: `=<`, `tisgal`, `%tsgl`
---

###Synopsis###

`=<`, `tisgal`, `[%tsgl p=twig q=twig]` is a synthetic hoon that
uses the product of `q` as the subject of `p`.
###Definition###

    ++  twig  
      $%  [%tsgl p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tsgl *]
      ==

###Notes###

