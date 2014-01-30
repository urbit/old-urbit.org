---
layout: post
category: doc
title: `%_`, `cencab`, `%_ncb`
---

###Synopsis###

`%_`, `cencab`, `[%_ncb p=twig q=twig]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%_ [%_ncb p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%_ncb *]
      ==

###Notes###

