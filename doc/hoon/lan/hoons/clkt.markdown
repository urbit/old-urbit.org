---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 27
title: colket
---




`:^`, `colket`, `[%clkt p=twig q=twig r=twig s=twig]` is a 
synthetic hoon that produces a cell `[p q r s]`.

###Definition###

    ++  twig  
      $%  [%clkt p=twig q=twig r=twig s=twig]
      ==

###Regular form (tall)###

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

###Regular form (wide)###

    :^(p q r s)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%clkt *]  [p.gen q.gen r.gen s.gen]
      ==

