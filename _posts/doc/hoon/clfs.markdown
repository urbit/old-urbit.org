---
layout: post
category: doc
title: `:/`, `colfas`, `%clfs`
---

###Synopsis###

`:/`, `colfas`, `[%clfs p=twig]` is a synthetic hoon that
produces `[%$ [%$ p ~] ~]`, ie, `[0 [0 p 0] 0]`.

###Definition###

    ++  twig  
      $%  [%clfs p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clfs *]
        [%clfs *]  =+(zoy=[%dtzz %ta %$] [%clsg [zoy [%clsg [zoy p.gen] ~]] ~])
      ==

###Notes###

`:/` is only used in the bowels of string interpolation.
