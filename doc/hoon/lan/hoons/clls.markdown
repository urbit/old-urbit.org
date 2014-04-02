---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 28
title: collus
---




`:+`, `collus`, `[%clls p=twig q=twig r=twig]` is a synthetic hoon that
produces a cell `[p q r]`.

###Definition###

    ++  twig  
      $%  [%clls p=twig q=twig r=twig]
      ==

###Regular form (tall)###

Kingside:

    :+  p
      q
    r

Queenside:

    :+  p   q
    r

###Regular form (wide)###

    :+(p q r)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%clls *]
      ==
