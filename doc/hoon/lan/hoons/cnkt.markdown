---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 36
title: cenket
---



`%^`, `cenket`, `[%cnkt p=twig q=twig r=twig s=twig]` is a 
synthetic hoon that slams gate `p` with `[%cntr q r s]`.

###Definition###

    ++  twig  
      $%  [%cnkt p=twig q=twig r=twig s=twig]
      ==

###Regular form (tall)###

Kingside:

    %^    p
        q
      r
    s

Queenside:

    %^  p  q
      r
    s

###Regular form (wide)###

    %^(p q r s)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnkt *]
        [%cnhp p.gen q.gen r.gen s.gen ~]
      ==

