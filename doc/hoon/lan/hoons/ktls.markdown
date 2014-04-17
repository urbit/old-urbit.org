---
layout: subpage
axis: doc-hoon
categories: ket rune
sort: 55
title: ketlus
---



#[ketlus, `^+`, %ktls](#ktls)

##Syntax

`^+`, `ketlus`, `[%ktls p=twig q=twig]` is a natural hoon that casts the product of `q` to the type of `p`, verifying that it contains the type of `q`.

###Form

####Tall

    ^+  p
        q

####Wide

    ^+(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%ktls p=twig q=twig]
      ==

###Expansion

    ++  mint
      ?-    gen
          [%ktls *]
        =+(hif=(nice (play p.gen)) [hif q:$(gen q.gen, gol hif)])
      ==

##Notes

None