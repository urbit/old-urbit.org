---
layout: subpage
axis: doc-hoon
categories: wut rune
sort: 93
title: wutket
---



#[wutket %wtkt](#wtkt)

##Syntax

`?^`, `wutket`, `[%wtkt p=wing q=twig r=twig]` is a synthetic hoon
that evaluates `r` if `p` is equal to the bunt for its tile, otherwise
`q` is evaluated.

###Form

####Tall

    ?^  p
      q
    r

####Wide

    ?^(p q r)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%wtkt p=wing q=twig r=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-  gen
        [%wtkt *]   [%wtcl [%wtts [%axil %atom %$] p.gen] r.gen q.gen]
      ==

##Notes

None
