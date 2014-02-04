---
layout: post
category: doc
title: `^+`, `ketlus`, `%ktls`
---

###Synopsis###

`^+`, `ketlus`, `[%ktls p=twig q=twig]` is a natural hoon that
mates the type of twig `p` to the formula of twig `q`, minted 
on the same subject - so long as the type of `q` nests within the
type of `p`.

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

Nesting is part of geometric polymorphism; see chapter 10.
