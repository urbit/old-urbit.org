---
layout: subpage
category: zap
title: zapgar
---

`!>`, `zapgar`, `[%zpgr p=twig]` is a synthetic hoon that
produces a vase (a [type noun] cell) with the value `p`.

###Definition###

    ++  twig  
      $%  [%zpgr p=twig]
      ==

###Regular form (tall)###

    !>  p

###Regular form (wide)###

    !>(p)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%zpgr *]
        [%cnhp [%cnzy %onan] [%zpsm [%bctr [%herb [%cnzy %abel]]] p.gen] ~]
      ==
