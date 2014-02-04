---
layout: post
category: doc
title: `%:`, `cencol`, `%cncl`
---

###Synopsis###

`%:`, `cencol`, `[%cncl p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%cncl p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cncl *]
      ==

###Notes###

