---
layout: post
category: doc
title: `.^`, `dotlus`, `%dtls`
---

###Synopsis###

`.^`, `dotlus`, `[%dtls p=twig]` is a natural hoon that generates
nock operator `4`, which increments an atomic operand.

###Definition###

    ++  twig  
      $%  [%dtls p=twig]
      ==

###Regular form (tall)###

    .^  p

###Regular form (wide)###

    .^(p)

###Compilation###
   
    ++  mint
      ?-    gen
        [%dtls *]  [(nice [%atom %$]) [%4 q:$(gen p.gen, gol [%atom %$])]]
      ==
