---
layout: subpage
category: dot
title: dotket
---

`.^`, `dotket`, `[%dtkt p=twig]` is a natural hoon that generates
nock operator `11`, which in virtual userspace nock (`mock`)
loads a file from the global namespace.

###Definition###

    ++  twig  
      $%  [%dtkt p=twig]
      ==

###Regular form (tall)###

    .^  p

###Regular form (wide)###

    .^(p)

###Compilation###
   
    ++  mint
      ?-    gen
        [%dtkt *]  [(nice %noun) [%11 q:$(gen p.gen, gol %noun)]]
      ==

