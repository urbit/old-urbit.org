---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 43
title: dotket
---



#[dotket, `.^`, %dtkt](#dtkt)

##Syntax

`.^`, `dotket`, `[%dtkt p=twig]` is a natural hoon that generates
nock operator `11`, which in virtual userspace nock (`mock`)
loads a file from the global namespace.


###Form

`p` is a twig

####Tall

    .^  p

####Wide

    .^(p)

####Irregular
None

###Reduction
None

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%dtkt p=twig]
      ==


###Expansion
   
    ++  mint
      ?-    gen
        [%dtkt *]  [(nice %noun) [%11 q:$(gen p.gen, gol %noun)]]
      ==

##Notes

