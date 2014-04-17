---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 106
title: zapfas
---



#[zapfas %zpfs](#zpfs)

##Syntax

`!/`, `zapfas`, `[%zpfs p=twig q=twig]` is a natural hoon that should
never be compiled.  When compiled with error checking turned on,
it reports its subject as an error.

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
      $%  [%zpfs p=twig]
      ==

###Expansion

    ++  mint
      ?-    gen
          [%zpfs *]  
        ?:  vet
          ~_  (dunk(sut (play p.gen)) 'lost')
          ~|(%mint-lost !!)
        [%void [%0 0]]
      ==


##Notes

We use `%zpfs` in `?-` to make sure all cases are handled.