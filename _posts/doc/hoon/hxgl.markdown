---
layout: post
category: doc
title: `#>`, `haxgal`, `%hxgl`
---

###Synopsis###

`#>`, `haxgal`, `[%hxgl p=tusk]` is a synthetic hoon that

###Definition###

    ++  twig  
      $%  [%hxgl p=tusk]
      ==
  ++  tusk  (list twig) 

###Regular form (tall)###

###Regular form (wide)###

###Irregular form###

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%hxgl *]
      ==

###Notes###
