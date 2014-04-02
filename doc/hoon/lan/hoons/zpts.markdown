---
layout: subpage
axis: doc-hoon
categories: zap rune
sort: 109
title: zaptis
---



`!=`, `zaptis`, `[%zpts p=twig]` is a natural hoon that produces
the formula of twig `p` as a noun.

###Definition###

    ++  twig  
      $%  [%zpts p=twig]
      ==

###Regular form (tall)###
  
    !=  p

###Regular form (wide)###

    !=(p) 

###Compilation###
    
    ++  mint
      ?-  gen
        [%zpts *]  [(nice %noun) [%1 q:$(vet |, gen p.gen)]]
      ==

###Notes###

Arguably should be changed to use a type, like %zpsm and %zpcm.
