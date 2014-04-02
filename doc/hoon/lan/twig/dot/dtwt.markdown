---
layout: subpage
category: dot
title: dotwut
---

`.?`, `dotwut`, `[%dtwt p=twig]` is a natural hoon that
calculates nock `3` (`&` for cell, `|` for atom) of `p`.

###Definition###

    ++  twig  
      $%  [%dtwt p=twig]
      ==

###Regular form (tall)###

    .?  p

###Regular form (wide)###

    .?(p)

###Compilation###
    
    ++  mint
      ?-  gen
        [%dtwt *]  [(nice bean) [%3 q:$(gen p.gen, gol %noun)]]
      ==

