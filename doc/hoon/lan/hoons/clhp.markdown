---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 26
title: colhep
---

#[colhep, `:-`, %clhp](#clhp)

##Syntax

`:-`, `colhep`, `[%clhp p=twig q=twig]` is a synthetic hoon that
produces the cell `[p q]`.

###Definition

    ++  twig  
      $%  [%clhp p=twig q=twig]
      ==

###Form

####Tall

    :-  p
    q

####Wide

    :-(p q)

####Irregular

    [p q]

###Expansion
    
    ++  open
      ^-  twig
      ?-  gen
        [%clhp *]  [p.gen q.gen]
      ==
