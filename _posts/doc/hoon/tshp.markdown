---
layout: post
category: doc
title: `=-`, `tishep`, `%tshp`
---

###Synopsis###

`=-`, `tishep`, `[%tshp p=twig q=twig]` is a synthetic hoon that
pushes `q` on the subject and sends it to `p`.

###Definition###

    ++  twig  
      $%  [%tshp p=twig q=twig]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tshp *]
      ==

###Notes###

