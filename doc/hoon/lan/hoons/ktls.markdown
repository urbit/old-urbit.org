---
layout: subpage
axis: doc-hoon
categories: ket rune
sort: 55
title: ketlus
---



`^+`, `ketlus`, `[%ktls p=twig q=twig]` is a natural hoon that
casts the product of `q` to the type of `p`, verifying that it
contains the type of `q`.

###Definition###

    ++  twig  
      $%  [%ktls p=twig q=twig]
      ==

###Regular form (tall)###

    ^+  p
    q

###Regular form (wide)###

    ^+(p q)

###Compilation###
    
    ++  mint
      ?-    gen
          [%ktls *]
        =+(hif=(nice (play p.gen)) [hif q:$(gen q.gen, gol hif)])
      ==

###Notes###

`^+` is the dual, and natural form, of `^-`, ie, cast.  The
difference is just that `^+` takes a twig and `^-` a tile.
