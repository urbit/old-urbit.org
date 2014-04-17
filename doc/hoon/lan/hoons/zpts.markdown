---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 109
title: zaptis
---



#[zaptis %zpts](#zpts)

##Syntax

    `!=`, `zaptis`, `[%zpts p=twig]` is a natural hoon that produces the formula of twig p as a noun.

###Form

####Tall

    !=  p

####Wide

    !=  p

####Irregular

    None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%zpts p=twig]
      ==

###Expansion

    ++  mint
      ?-  gen
        [%zpts *]  [(nice %noun) [%1 q:$(vet |, gen p.gen)]]
      ==

##Notes

Arguably should be changed to use a type, like %zpsm and %zpcm.