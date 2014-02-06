---
layout: post
category: doc
title: `?.`, `wutdot`, `%wtdt`
---

###Synopsis###

`?.`, `wutdot`, `[%wtdt p=twig q=twig r=twig]` is a synthetic hoon that
evaluates `r` if `p` evaluates to true, otherwise `q` is
evaluated. This is Hoon's "unless".

###Definition###

    ++  twig  
      $%  [%wtdt p=twig q=twig r=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtdt *]
      ==

###Notes###

