---
layout: post
category: doc
title: `|_`, `barcab`, `%brcb`
---

###Synopsis###

`|_`, `barcab`, `[%brcb p=tile q=(map term foot)]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%brcb p=tile q=(map term foot)]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brcb *]
        [%tsls [%bctr p.gen] [%brcn q.gen]]
      ==

###Notes###

