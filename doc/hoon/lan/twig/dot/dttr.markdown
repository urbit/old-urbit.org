---
layout: subpage
category: dot
title: dottar
---

`.*`, `dottar`, `[%dttr p=twig q=twig]` is a natural hoon that
calculates the nock of subject `p`, formula `q`.

###Definition###

    ++  twig  
      $%  [%dttr p=twig q=twig]
      ==

###Regular form (tall)###

    .*  p
    q

###Regular form (wide)###

    .*(p q)

###Compilation###
    
    ++  mint
      ?-    gen
          [%dttr *]
        [(nice %noun) [%2 q:$(gen p.gen, gol %noun) q:$(gen q.gen, gol %noun)]]
      ==


