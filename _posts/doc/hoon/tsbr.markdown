---
layout: post
category: doc
title: `=|`, `tisbar`, `%tsbr`
---

###Synopsis###

`=|`, `tisbar`, `[%tsbr p=tile q=twig]` is a synthetic hoon that
produces `q` with the bunted tile `p` as its subject.

###Definition###

    ++  twig  
      $%  [%tsbr p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tsbr *]
      ==

###Notes###

