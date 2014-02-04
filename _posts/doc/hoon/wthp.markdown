---
layout: post
category: doc
title: `?-`, `wuthep`, `%wthp`
---

###Synopsis###

`?-`, `wuthep`, `[%wthp p=wing q=tine]` is a synthetic hoon that
works as a 'switch/case' construct.

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

