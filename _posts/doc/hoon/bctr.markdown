---
layout: post
category: doc
title: `$*`, `buctar`, `%bctr`
---

###Synopsis###

`$*`, `buctar`, `[%bctr p=tile]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%bctr p=tile]
      ==

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bctr *]
        [%ktsg ~(bunt al p.gen)]
      ==

###Notes###

