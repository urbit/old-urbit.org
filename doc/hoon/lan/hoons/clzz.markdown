---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 31
title: colzaz
---




`%clzz`, `[%clzz p=tusk]` is a synthetic hoon that promotes
its tusk `p` within a `%clsg` or `%cltr` tusk.

###Definition###

    ++  twig  
      $%  [%clzz p=twig]
      ==
    ++  tusk  (list twig)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%clzz *]  open(gen [%clsg p.gen])
      ==

###Notes###

See `%clsg` and `%cltr` for how `%clzz` works.
