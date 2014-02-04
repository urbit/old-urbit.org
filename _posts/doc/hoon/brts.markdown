---
layout: post
category: doc
title: `|=`, `bartis`, `%brts`
---

###Synopsis###

`|=`, `bartis`, `[%brts p=tile q=twig]` is a synthetic hoon that
creates a gate (i.e. a core with a single unnamed dry arm) with the
bunt of tile `p` in its context.

###Definition###

    ++  twig  
      $%  [%brts p=tile q=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brts *]
        [%brcb p.gen (~(put by *(map term foot)) %$ [%ash q.gen])]
      ==

###Notes###

