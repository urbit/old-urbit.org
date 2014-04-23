---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 23
title: colcab
---

#[colcab, `:_`, %clcb](#clcb)

##Syntax

`:_`, `colcab`, `[%clcb p=twig q=twig]` is a synthetic hoon that
produces the cell `[q p]`.

###Definition

    ++  twig  
      $%  [%clcb p=twig q=twig]
      ==

###Form

####Tall

    :_  p
    q

####Wide

    :_(p q)

###Expansion
    
    ++  open
      ^-  twig
      ?-  gen
        [%clcb *]  [q.gen p.gen]
      ==

###Notes

See also `%clhp`.
