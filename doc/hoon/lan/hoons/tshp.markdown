---
layout: subpage
axis: doc-hoon
categories: tis rune
sort: 81
title: tishep
---



#[tishep, `=-`, %tshp](#tshp)

##Syntax

`=-`, `tishep`, `[%tshp p=twig q=twig]` is a synthetic hoon that
pushes `q` on the subject and sends it to `p`.

###Form

####Tall

    =-  p
    q

####Wide

    =-(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%tshp p=twig q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%tshp *]  [%tsls q.gen p.gen]
      ==

##Notes

`=-`, the opposite of `=+`, is very useful for code arrangement
when `q` is much bigger than `p`.
