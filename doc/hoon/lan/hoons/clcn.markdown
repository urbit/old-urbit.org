---
layout: subpage
axis: doc-hoon
categories: col rune
sort: 24
title: colcen
---

#[colcen, `:%`, $clcn](#clcn)

##Syntax

`:%`, `colcen`, `[%clcn p=tusk]` is a synthetic hoon that
produces a cell `[[p ~] ~]`.

###Definition

    ++  twig  
      $%  [%clcn p=twig]
      ==
    ++  tusk  (list twig)

###Form

####Tall

    :%  i.p
        i.t.p
        i.t.t.p
    ==

####Wide

    :%(i.p i.t.p i.t.t.p)

####Irregular

    %[i.p i.t.p i.t.t.p]

###Expansion
    
    ++  open
      ^-  twig
      ?-  gen
        [%clcn *]  [[%clsg p.gen] [%bczp %null]]
      ==
