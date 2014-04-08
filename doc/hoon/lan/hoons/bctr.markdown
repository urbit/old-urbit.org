---
layout: subpage
axis: doc-hoon
categories: buc rune
sort: 9
title: buctar
---

#[buctar, `$*`, %bctr](#bctr)

##Syntax

`$*`, `buctar`, `[%bctr p=tile]` is a synthetic rune that
produces the bunt (default value) for `p` as a compile-time
constant.

###Form

`p` is a tile.

####Tall

    $*  p

####Wide

    $*(p)

####Irregular

    *p

###Reduction

    $*  p

reduces to

    ^~  ~(bunt al p)

###Examples

##Semantics

`%bctr` is a twig.

###Definition

    ++  twig  
      $%  [%bctr p=tile]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%bctr *]
        [%ktsg ~(bunt al p.gen)]
      ==

###Notes

See the discussion of tiles in chapter 9.
