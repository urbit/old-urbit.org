---
layout: subpage
axis: doc-hoon
categories: ket rune
sort: 54
title: kethep
---



#[kethep, `^-`, %kthp](#kthp)

##Syntax

`^-`, `kethep`, `[%kthp p=tile q=twig]` is a synthetic hoon that casts `q` to `~(bunt al p)`, ie, the icon of `p`.

###Form

####Tall

    ^-  p
        q

####Wide

    ^-(p q)

####Irregular

    `p`q

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%kthp p=tile q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%kthp *]  [%ktls ~(bunt al p.gen) q.gen]
      ==

##Notes

None