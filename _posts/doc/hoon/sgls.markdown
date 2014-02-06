---
layout: post
category: doc
title: `~+`, `siglus`, `%sgls`
---

###Synopsis###

`~+`, `siglus`, `[%sgls p=twig]` is a synthetic hoon that
hints to the interpreter to memoize (cache) the computation 
of `p`.

###Definition###

    ++  twig  
      $%  [%sgls p=twig]
      ==

###Regular form (tall)###

    ~+  
    p

###Regular form (wide)###

    ~+(p)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%sgls *]  [%sggr [%memo %dtzz %$ p.gen] q.gen]
      ==

###Notes###

At present, the memo cache is cleared on every event.
