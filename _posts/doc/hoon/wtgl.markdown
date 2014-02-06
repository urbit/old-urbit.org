---
layout: post
category: doc
title: `?<`, `wutgal`, `%wtgl`
---

###Synopsis###

`?<`, `wutgal`, `[%wtgl p=twig q=twig]` is a synthetic hoon that
produces `q`, asserting that `p` is no (`|`, 1).

###Definition###

    ++  twig  
      $%  [%wtgl p=twig]
      ==

###Regular form (tall)###

    ?<  p
    q

###Regular form (wide)###

    ?<(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%wtgl *]   [%wtcl p.gen [%zpzp ~] q.gen]
      ==

###Notes###


