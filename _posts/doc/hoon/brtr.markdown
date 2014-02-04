---
layout: post
category: doc
title: `|*`, `bartar`, `%brtr`
---

###Synopsis###

`|*`, `bartar`, `[%brtr p=tile q=twig]` is a synthetic hoon that
creates a wet gate (i.e. a core with a single unnamed wet arm) with
the bunt of tile `p` in its context.

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

