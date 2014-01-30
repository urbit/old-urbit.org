---
layout: post
category: doc
title: `#>`, `haxgar`, `%hxgr`
---

###Synopsis###

`#>`, `haxgar`, `[%hxgr p=tusk]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%hxgr p=tusk]
      ==
  ++  tusk  (list twig) 

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%hxgr *]
      ==

###Notes###


