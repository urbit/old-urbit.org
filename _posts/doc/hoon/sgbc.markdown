---
layout: post
category: doc
title: `~$`, `sigbuc`, `%sgbc`
---

###Synopsis###

`~$`, `sigbuc`, `[%sgbc p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%sgbc p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%sgbc *]
      ==

###Notes###

