---
layout: post
category: doc
title: `=<`, `tisgal`, `%tsgl`
---

###Synopsis###

`=<`, `tisgal`, `[%tsgl p=twig q=twig]` is a synthetic hoon that
uses the product of `q` as the subject of `p`.

###Definition###

    ++  twig  
      $%  [%tsgl p=twig q=twig]
      ==

###Regular form (tall)###

    =<  p
    q

###Regular form (wide)###

    =<(p q)

###Irregular form###

    p:q

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%tsgl *]  [%tsgr q.gen p.gen]
      ==

###Notes###

