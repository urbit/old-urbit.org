---
layout: subpage
axis: doc-hoon
categories: bar rune
sort: 21
title: bartis
---

#[bartis, `|=`, %brts](#brts)

##Syntax

`|=`, `bartis`, `[%brts p=tile q=twig]` is a synthetic hoon that
produces a dry `%gold` gate with arm `q`, sample `[%bctr p]`.

###Form
`p` is a tile
`q` is a twig

####Tall

    |=  p
    q

####Wide

    |=(p q)

####Irregular
None

###Reduction

    |=  p
      q

reduces to

    |_  p
    ++  $
      q
    --

reduces to [`|_` link]

    =+  $*(p)
    |%  ++  $
      q
    --

###Examples

    ++  add                                                 ::  add
      ~/  %add
      |=  [a=@ b=@]
      ^-  @
      ?:  =(0 a)
        b
      $(a (dec a), b +(b))

In ++add, `|=` creates a gate whose sample takes two atoms
labeled `a` and `b`, and whose arm evaluates an expression that
produces the sum of the atoms.

##Semantics

`%brts` is a twig.

###Definition###

    ++  twig
      $%  [%brts p=tile q=twig]
      ==

###Expansion###

    ++  open
      ^-  twig
      ?-    gen
          [%brts *]
        [%brcb p.gen (~(put by *(map term foot)) %$ [%ash q.gen])]
      ==

