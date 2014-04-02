---
layout: subpage
category: col
title: colcen
---

`:%`, `colcen`, `[%clcn p=tusk]` is a synthetic hoon that
produces a cell `[[p ~] ~]`.

###Definition###

    ++  twig  
      $%  [%clcn p=twig]
      ==
    ++  tusk  (list twig)

###Regular form (tall)###

    :%  i.p
        i.t.p
        i.t.t.p
    ==

###Regular form (wide)###

    :%(i.p i.t.p i.t.t.p)

###Irregular form###

    %[i.p i.t.p i.t.t.p]

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%clcn *]  [[%clsg p.gen] [%bczp %null]]
      ==
