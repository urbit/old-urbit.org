---
layout: post
category: doc
title: `.=`, `dtts`, `%dtts`
---

###Synopsis###

`.=`, `dottis`, `[dtts p=twig q=twig]` is a natural hoon that
applies nock `5` (equals) to the products of p and q.

###Definition###

    ++  twig  
      $%  [%dtts p=twig q=twig]
      ==

###Regular form (tall)###

    .=  p
    q

###Regular form (wide)###

    .=(p q)

###Compilation###
    
    ++  mint
      ?-    gen
          [%dtts *]
        [(nice bean) [%5 q:$(gen p.gen, gol %noun) q:$(gen q.gen, gol %noun)]]
      ==

