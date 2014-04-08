---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 20
title: bartar
---

#[bartar, `|*`, %brtr](#brtr)

##Syntax

`|*`, `bartar`, `[%brtr p=tile q=twig]` is a synthetic hoon that
produces a vulcanized wet gate with arm `q`, sample `[%bctr p]`.

###Form
`p` is a tile
`q` is a twig

####Tall

    |*  p
    q

####Wide

    |*(p q)

####Irregular
None

###Reduction

    |*  p
    q

reduces to

    |/  p
    +-  $
      q
    --

###Examples


    ++  flop                                                ::  reverse
      ~/  %flop
      |*  a=(list)
      =>  .(a (homo a))
      ^+  a
      =+  b=`_a`~
      |-
      ?@  a
        b
      $(a t.a, b [i.a b])

In ++flop, `|*` creates a wet gate that takes a ++list (link).

##Semantics

`%brtr` is a twig.

###Definition###

    ++  twig  
      $%  [%brtr p=tile q=twig]
      ==

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brtr *]
        [%brfs p.gen (~(put by *(map term foot)) %$ [%elm q.gen])]
      ==

##Notes
