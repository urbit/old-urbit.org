---
layout: post
category: doc
title: `=+`, `tislus`, `%tsls`
---

###Synopsis###

`=+`, `tislus`, `[%tsls p=twig q=twig]` is a synthetic hoon that
uses [`p` .] as the subject of `q` (i.e., adds p to its context).
###Definition###

    ++  twig  
      $%  [%tsls p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tsls *]
      ==

###Notes###

