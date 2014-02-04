---
layout: post
category: doc
title: `?~`, `wutsig`, `%wtsg`
---

###Synopsis###

`?~`, `wutsig`, `[%wtsg p=wing q=twig r=twig]` is a synthetic hoon that
evaluates `q` if `p` is a list, otherwise `r`
is evaluated.

###Definition###

    ++  twig  
      $%  [%wtsg p=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%wtsg *]
      ==

###Notes###

