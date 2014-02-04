---
layout: post
category: doc
title: `|/`, `barfas`, `%brfs`
---

###Synopsis###

`|/`, `barfas`, `[%brfs p=tile q=(map term foot)]` is a synthetic hoon
that creates a core with the bunt of tile `p` in its context and wet
arms `q`.


###Definition###

    ++  twig  
      $%  [%brfs p=tile q=(map term foot]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brfs *]
      ==

###Notes###

