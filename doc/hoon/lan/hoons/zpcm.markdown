---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 105
title: zapcom
---



#[zapcom, `!,`, %zpcm](#zpcm)

##Syntax

`!,`, `zapcom`, `[%zpcm p=twig q=twig]` is a natural hoon that
inserts twig `q` as a constant, typed with the type of twig `p`.

###Form

####Tall

    ?,  p
        q

####Wide

    ?,(p q)

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%zpcm p=twig q=twig]
      ==

###Expansion

    ++  mint
      ?-  gen
        [%zpcm *]  [(nice (play p.gen)) [%1 q.gen]]
      ==

##Notes

The compiler should verify that `p` is actually the type of the
twigs it uses, but doesn't at present.
