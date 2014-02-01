---
layout: post
category: doc
title: `|.`, `bardot`, `%brdt`
---

###Synopsis###

`|.`, `bardot`, `[%brdt p=twig]` is a synthetic hoon that creates a
gate, i.e. a core with a single unnamed dry arm.

###Definition###

    ++  twig  
      $%  [%brdt p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brdt *]  
        [%brcn (~(put by *(map term foot)) %$ [%ash p.gen])]
      ==

###Notes###

