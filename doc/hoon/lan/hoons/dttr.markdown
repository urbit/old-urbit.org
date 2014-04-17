---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 45
title: dottar
---



#[dottar, `.*`, %dttr](#dttr)

##Syntax

`.*`, `dottr`, `[%dttr p=twig q=twig]` is a natural hoon that calculates the nock of subject `p`, formula `q`.

###Form

####Tall

    .*  p
        q

####Wide

    .=(p q)

####Irregular
None

###Reduction

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%dttr p=twig q=twig]
      ==


###Expansion

    ++  mint
      ?-    gen
        [%dttr *]
      [(nice %noun) [%2 q:$(gen p.gen, gol %noun) q:$(gen q.gen, gol %noun)]]
  ==

##Notes
