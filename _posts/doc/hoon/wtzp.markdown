---
layout: post
category: doc
title: `?!`, `wutzap`, `%wtzp`
---

###Synopsis###

`?!`, `wutzap`, `[%wtzp p=twig]` is a synthetic hoon that
produces the logical "not" of `p`.

###Definition###

    ++  twig  
      $%  [%wtzp p=twig]
      ==

###Regular form (tall)###

    ?!  p

###Regular form (wide)###

    ?!(p)

###Irregular form###

    !p

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%wtzp *]  [%wtcl p.gen [%dtzz %f 1] [%dtzz %f 0]]
      ==
