---
layout: post
category: doc
title: `#>`, `haxgal`, `%hxgl`
---

###Synopsis###

`#>`, `haxgal`, `[%hxgl p=tusk]` is a synthetic hoon that invokes the
pretty-printer on `p`, producing a tank (tree of pretty-printer
elements).
###Definition###

    ++  twig  
      $%  [%hxgl p=tusk]
      ==
  ++  tusk  (list twig) 

###Regular form (tall)###
None.
###Regular form (wide)###
None.
###Irregular form###
>i.p i.t.p ...<
###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%hxgl *]
      ==

###Notes###
