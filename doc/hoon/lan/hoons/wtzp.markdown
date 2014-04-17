---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 103
title: wutzap
---



#[wutzap %wtzp](#wtzp)

##Syntax

`?!`, `wutzap`, `[%wtzp p=twig]` is a synthetic hoon that
produces the logical "not" of `p`.

###Form

####Tall

    ?!  p

####Wide

    ?!(p)

####Irregular

    !p

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtzp p=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%wtzp *]  [%wtcl p.gen [%dtzz %f 1] [%dtzz %f 0]]
      ==

##Notes