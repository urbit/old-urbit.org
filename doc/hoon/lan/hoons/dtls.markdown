---
layout: subpage
axis: doc-hoon
categories: dot rune
sort: 44
title: dotlus
---



#[dotlus, `.+`, %dtls](#dtls)

##Syntax

`.+`, `dotlus`, `[%dtls p=twig]` is a natural hoon that generates
nock operator `4`, which increments an atomic operand.

###Form

####Tall

    .+  p

####Wide

    .+(p)

####Irregular

    +(p)

###Reduction
None, .+ is natural

###Examples

##Semantics

###Definition

    ++  twig  
      $%  [%dtls p=twig]
      ==


###Expansion

    ++  mint
      ?-    gen
        [%dtls *]  [(nice [%atom %$]) [%4 q:$(gen p.gen, gol [%atom %$])]]
      ==

##Notes
