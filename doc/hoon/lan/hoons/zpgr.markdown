---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 107
title: zapgar
---



#[zapgar %zpgr](#zpgr)

##Syntax

`!>`, `zapgar`, `[%zpgr p=twig]` is a synthetic hoon that
produces a vase (a [type noun] cell) with the value `p`.

###Form

####Tall

    !>  p

####Wide

    !>(p)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%zpgr p=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%zpgr *]
        [%cnhp [%cnzy %onan] [%zpsm [%bctr [%herb [%cnzy %abel]]] p.gen] ~]
      ==

##Notes

None