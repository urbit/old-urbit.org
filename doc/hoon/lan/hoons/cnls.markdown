---
layout: subpage
axis: doc-hoon
categories: cen rune
sort: 37
title: cenlus
---



`%+`, `cenlus`, `[%cnls p=twig q=twig r=twig]` is a synthetic hoon 
that slams gate `p` with `[%cntr q r]`.

###Definition###

    ++  twig  
      $%  [%cnls p=twig q=twig r=twig]
      ==

###Regular form (tall)###

Kingside:

    %+  p
      q
    r

Queenside:

    %+  p  q
    r

###Regular form (wide)###

    %+(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%cnls *]
        [%cnhp p.gen q.gen r.gen ~]
      ==
