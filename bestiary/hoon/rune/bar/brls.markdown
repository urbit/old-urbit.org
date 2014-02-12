---
layout: subpage
category: bar
title: barlus
---

`|+`, `barlus`, `[%brls p=tile q=twig]` is a synthetic hoon that
produces a dry `%iron` gate with arm `q`, sample `[%bctr p]`.

###Definition###

    ++  twig  
      $%  [%brls p=tile q=twig]
      ==

###Regular form (tall)###

    |+  p
    q

###Regular form (wide)###

    |+(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%brls *]
        [%ktbr [%brts p.gen q.gen]]
      ==
