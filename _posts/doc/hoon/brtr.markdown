---
layout: post
category: doc
title: `|*`, `bartar`, `%brtr`
---

###Synopsis###

`|*`, `bartar`, `[%brtr p=tile q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%brtr p=tile q=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brtr *]
        [%brfs p.gen (~(put by *(map term foot)) %$ [%elm q.gen])]
      ==

###Notes###

