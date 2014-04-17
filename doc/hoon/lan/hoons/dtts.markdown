---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 46
title: dottis
---



#[dottis, `.=`, %dtts](#dtts)

##Syntax

`.=`, `dottis`, `[%dtts p=twig q=twig]`is a natural hoon that applies nock 5 (equals) to determine if the products of p and q are equivalent.

###Form

####Tall

    .=  p
        q

####Wide

    .=(p q)

####Irregular

    =(p q)

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%dtts p=twig q=twig]
      ==

###Expansion

    ++  mint
      ?-  gen
        [%dtts *]
      [(nice bean) [%5 q:$(gen p.gen, gol %noun) q:$(gen q.gen, gol %noun)]]
      ==

##Notes
