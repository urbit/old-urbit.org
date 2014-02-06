---
layout: post
category: doc
title: `=+`, `tislus`, `%tsls`
---

###Synopsis###

`=+`, `tislus`, `[%tsls p=twig q=twig]` is a synthetic hoon that
pushes `p` on the subject and sends it to `q`.

###Definition###

    ++  twig  
      $%  [%tsls p=twig q=twig]
      ==

###Regular form (tall)###

    =+  p
    q

###Regular form (wide)###

    =+(p q)

###Expansion###
    
    ++  open
      ^-  twig
      ?-  gen
        [%tsls *]  [%tsgr [p.gen [~ 1]] q.gen]
      ==

###Notes###

`%tsls` is the Hoon equivalent of Nock `8`.  It is a synthetic
hoon, though, because we recognize the Nock pattern and optimize
it in code generation.
