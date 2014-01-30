---
layout: post
category: doc
title: `?-`, `wuthep`, `%wthp`
---

###Synopsis###

`?-`, `wuthep`, `[%wthp p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%wthp p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wthp *]
      ==

###Notes###

