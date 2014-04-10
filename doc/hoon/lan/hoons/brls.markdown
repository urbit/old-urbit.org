---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 19
title: barlus
---

#[barlus, `|+`, %brls](#brls)

##Syntax

`|+`, `barlus`, `[%brls p=tile q=twig]` is a synthetic hoon that
produces a dry `%iron` gate with arm `q`, sample `[%bctr p]`.

###Forms

`p` is a tile
`q` is a twig

###Tall

    |+  p
    q

###Wide

    |+(p q)

###Irregular
None

###Reduction

    |+  p
    q

reduces to

    ^|  
    |=  p
    q

reduces to [|= link]

    ^|
    =+  $*(p)
    |%  ++  $
      q
    --

###Examples


##Semantics

`%brls` is a twig. 

###Definition

    ++  twig  
      $%  [%brls p=tile q=twig]
      ==

###Expansion
    
    ++  open
      ^-  twig
      ?-    gen
          [%brls *]
        [%ktbr [%brts p.gen q.gen]]
      ==

##Notes
