---
layout: post
category: doc
title: `~|`, `%sgbr`, `sigbar`
---

###Synopsis###

`~|`, `%sgbr`, `[sigbar p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [sigbar p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [sigbar *]
      ==

###Notes###

