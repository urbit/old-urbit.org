---
layout: post
category: doc
title: `=-`, `tishep`, `%tshp`
---

###Synopsis###

`=-`, `tishep`, `[%tshp p=twig q=twig]` is a synthetic hoon that
pushes `q` on the subject and sends it to `p`.

###Definition###

    ++  twig  
      $%  [%tshp p=twig q=twig]
      ==

###Regular form (tall)###

    =-  p
    q

###Regular form (wide)###

    =-(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-    gen
          [%tshp *]  [%tsls q.gen p.gen]
      ==

###Notes###

`=-`, the opposite of `=+`, is very useful for code arrangement
when `q` is much bigger than `p`.
