---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 108
title: zapsem
---



#[zapsem, `!;`, %zpsm](#zpsm)

##Syntax

`!;`, `zapsem`, `[%zpsm p=twig q=twig]` is a natural hoon that
produces the product of twig `q` as a `[type noun]` pair, with
twig `p` defining the type of the type.

###Form

####Tall

    !;  p
        q
####Wide

    !;(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%zpgr p=twig]
      ==

###Expansion

    ++  mint
      ?-  gen
          [%zpsm *]  
        =+  vos=$(gol %noun, gen q.gen)
        [(nice (cell (play p.gen) p.vos)) (cons [%1 p.vos] q.vos)]
      ==

##Notes

The compiler should verify that `p` is actually the type of the
types it uses, but doesn't at present.
