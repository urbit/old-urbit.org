---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 9
title: buctar
---



`$*`, `buctar`, `[%bctr p=tile]` is a synthetic hoon that
produces the bunt (default value) for `p` as a compile-time
constant.

###Definition###

    ++  twig  
      $%  [%bctr p=tile]
      ==

###Regular form (tall)###

    $*  p

###Regular form (wide)###

    $*(p)

###Irregular form###

    *p

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%bctr *]
        [%ktsg ~(bunt al p.gen)]
      ==

###Notes###

See the discussion of tiles in chapter 9.
