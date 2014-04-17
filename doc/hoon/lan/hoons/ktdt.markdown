---
layout: subpage
axis: doc-hoon
categories: ket rune
sort: 53
title: ketdot
---



#[ketdot, `^.`, %ktdt](#ktdt)

##Syntax

`^.`, `ketdot`, `[%ktdt p=twig q=twig]` is a synthetic hoon that casts `q` to the type of `(p q)`.

###Form

####Tall

    ^.  p
        q

####Wide

    None

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%ktdt p=twig q=twig]
      ==

###Expansion

    ++  open
      ^-  twig
      ?-    gen
          [%ktdt *]
        [%ktls [%cnhp p.gen q.gen ~] q.gen]
      ==

##Notes

None