---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 27
title: colket
---

#[colket, `:^`, %clkt](#clkt)

##Syntax

`:^`, `colket`, `[%clkt p=twig q=twig r=twig s=twig]` is a 
synthetic hoon that produces a cell `[p q r s]`.

###Definition

    ++  twig  
      $%  [%clkt p=twig q=twig r=twig s=twig]
      ==

###Form

####Tall

Kingside:

    :^    p
        q
      r
    s

Queenside:

    :^  p  q
      r
    s

    :^  p  q  r  
    s

####Wide

    :^(p q r s)

###Expansion
    
    ++  open
      ^-  twig
      ?-  gen
        [%clkt *]  [p.gen q.gen r.gen s.gen]
      ==

