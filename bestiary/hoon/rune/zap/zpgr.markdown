---
layout: subpage
category: zap
title: zapgar
---

`!>`, `zapgar`, `[%zpgr p=twig]` is a synthetic hoon that
creates a vase (a type/value pair) for `p`.

###Definition###

    ++  twig  
      $%  [%zpgr p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%zpgr *]
      ==

###Notes###

